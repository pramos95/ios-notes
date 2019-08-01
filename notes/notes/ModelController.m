//
//  ModelController.m
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "ModelController.h"

@implementation ModelController
static ModelController *_instance;
+ (ModelController *) getInstance {
    if (_instance == nil) {
        _instance = [ModelController new];
    }
    return _instance;
}

- (ModelController *)init {
    self = [super init];
    self.notesArray = [NSMutableArray array];
    self.categoriesArray = [NSMutableArray array];
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

+ (NSArray *)Notes:(NSArray *)notes ofCategory:(NoteCategory *)category {
    NSMutableArray *res = [NSMutableArray new];
    for (Note *note in notes) {
        if ([note.categoryId isEqualToNumber:category.categoryId]) {
            [res addObject:note];
        }
    }
    return res;
}

@end
