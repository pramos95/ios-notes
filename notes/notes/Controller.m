//
//  Controller.m
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "Controller.h"

@implementation Controller

- (Controller*)init {
    self = [super init];
    self.notesArray = [NSMutableArray array];
    self.categoriesArray = [NSMutableArray array];
    return self;
}

- (void)loadData {
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notes" ofType:@"json"]];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    
    NSArray *notes = dictionary[@"notes"];
    NSArray *categories = dictionary[@"categories"];
    
    for (NSDictionary *note in notes){
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[note[@"createdDate"] doubleValue]];
        Note *object = [[Note alloc] initWithId:note[@"id"] title:note[@"title"] content:note[@"content"] contentDate:date categoryId:[NSNumber numberWithInt:[note[@"categoryId"] integerValue]]];
        [self.notesArray addObject:object];
    }

    for (NSDictionary *category in categories) {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[category[@"createdDate"] doubleValue]];
        NSNumber *categoryId = [NSNumber numberWithInt:[category[@"id"] integerValue]];
        Category *object = [[Category alloc] initWithId:categoryId title:category[@"title"] createdDate:date];
        [self.categoriesArray addObject:object];
    }
}

- (NSArray*)getData{
    NSMutableArray *res = [NSMutableArray new];
    for (Note *note in self.notesArray){
        [res addObject:note.noteId];
        [res addObject:note.title];
        [res addObject:note.content];
        [res addObject:[note.contentDate description]];
        Category *category;
        for (Category *cat in self.categoriesArray) {
            if ([cat.categoryId isEqualToNumber:note.categoryId]) {
                category = cat;
                break;
            }
        }
        [res addObject:category.title];
        [res addObject:[category.createdDate description]];
    }
    return res;
}

@end
