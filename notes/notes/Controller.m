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
    [self loadData];
    return self;
}

- (void)loadData {
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notes" ofType:@"json"]];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    
    NSArray *notes = dictionary[@"notes"];
    NSArray *categories = dictionary[@"categories"];
    
    for (NSDictionary *note in notes){
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[note[@"createdDate"] doubleValue]];
        Note *object = [[Note alloc] initWithId:note[@"id"] title:note[@"title"] content:note[@"content"] contentDate:date categoryId:note[@"categoryId"]];
        [self.notes addObject:object];
    }
    
    for (NSDictionary *category in categories) {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[category[@"createdDate"] doubleValue]];
        Category *object = [[Category alloc] initWithId:category[@"id"] title:category[@"title"] createdDate:date];
        [self.categories addObject:object];
    }
}

@end
