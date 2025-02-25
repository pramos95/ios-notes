//
//  Category.m
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "NoteCategory.h"

@implementation NoteCategory

- (NoteCategory *)initWithId:(NSNumber *)categoryId title:(NSString *)title createdDate:(NSDate *)createdDate {
    self = [super init];
    self.categoryId = categoryId;
    self.title = title;
    self.createdDate = createdDate;
    
    return self;
}

@end
