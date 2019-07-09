//
//  Note.m
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "Note.h"

@implementation Note
-(Note*)initWithId:(NSString*)Id title:(NSString*)title content:(NSString*)content contentDate:(NSDate*)contentDate categoryId:(NSNumber*)categoryId {
    self = [super init];
    self.Id = Id;
    self.title = title;
    self.content = content;
    self.contentDate = contentDate;
    self.categoryId = categoryId;
    return self;
}

    
@end
