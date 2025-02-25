//
//  ModelController.m
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "ModelController.h"
@interface ModelController ()

@property (strong, nonatomic) NSNumber *nextCategoryId;

@end

@implementation ModelController

NSString *const refeshNotificationName = @"RefeshTable";

+ (id)sharedInstance {
    static ModelController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    self.notesArray = [NSMutableArray array];
    self.categoriesArray = [NSMutableArray array];
    self.nextCategoryId = [NSNumber numberWithInt:0];
    return self;
}

- (void)loadData:(void (^)(NSError * _Nullable error))completionHandler {
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:@"https://s3.amazonaws.com/kezmo.assets/sandbox/notes.json"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && location) {
            NSData *JSONData = [NSData dataWithContentsOfURL:location];
            [self parseJSON:JSONData];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            completionHandler (error);
        });
    }];
    [downloadTask resume];
}

-(void)parseJSON:(NSData *)JSONData {
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    NSArray *notes = dictionary[@"notes"];
    NSArray *categories = dictionary[@"categories"];
    
    for (NSDictionary *note in notes){
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[note[@"createdDate"] doubleValue]];
        Note *object = [[Note alloc] initWithId:note[@"id"] title:note[@"title"] content:note[@"content"] contentDate:date categoryId:[NSNumber numberWithInt:[note[@"categoryId"] intValue]]];
        [self.notesArray addObject:object];
    }
    
    for (NSDictionary *category in categories) {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[category[@"createdDate"] doubleValue]];
        NSNumber *categoryId = [NSNumber numberWithInt:[category[@"id"] intValue]];
        if (categoryId.intValue >= self.nextCategoryId.intValue) {
            self.nextCategoryId = [NSNumber numberWithInt:categoryId.intValue + 1];
        }
        NoteCategory *object = [[NoteCategory alloc] initWithId:categoryId title:category[@"title"] createdDate:date];
        [self.categoriesArray addObject:object];
    }
}

- (NSArray *)getNotes {
    return self.notesArray;
}

- (NSArray *)getCategories {
    return self.categoriesArray;
}

- (NoteCategory *)categoryWithId:(NSNumber *)categoryId {
    for (NoteCategory *category in self.categoriesArray) {
        if ([category.categoryId isEqualToNumber:categoryId]) {
            return category;
        }
    }
    return nil;
}

- (NSArray *)notesOfCategory:(NoteCategory *)category {
    NSMutableArray *res = [NSMutableArray new];
    for (Note *note in self.notesArray) {
        if ([note.categoryId isEqualToNumber:category.categoryId]) {
            [res addObject:note];
        }
    }
    return res;
}

- (void)addNote:(Note *)note {
    [self.notesArray addObject:note];
    NSNotification *notification = [NSNotification notificationWithName:refeshNotificationName object:self];
    [NSNotificationCenter.defaultCenter postNotification:notification];
}

- (void)editNote:(Note *)current withModifiedNote:(Note *)modifiedNote {
    [self.notesArray replaceObjectAtIndex:[self.notesArray indexOfObject:current] withObject:modifiedNote];
    NSNotification *notification = [NSNotification notificationWithName:refeshNotificationName object:self];
    [NSNotificationCenter.defaultCenter postNotification:notification];
}

- (void)addCategoryWithTitle:(NSString *)title {
    BOOL categoryExists = false;
    for (NoteCategory *cat in self.categoriesArray) {
        if ([cat.title isEqualToString:title]) {
            categoryExists = YES;
            break;
        }
    }
    if (!categoryExists) {
        NoteCategory *cat = [[NoteCategory alloc] initWithId:self.nextCategoryId title:title createdDate:[NSDate date]];
        [self.categoriesArray addObject:cat];
        self.nextCategoryId = [NSNumber numberWithInt:self.nextCategoryId.intValue + 1];
        NSNotification *notification = [NSNotification notificationWithName:refeshNotificationName object:self];
        [NSNotificationCenter.defaultCenter postNotification:notification];
    }
}

@end
