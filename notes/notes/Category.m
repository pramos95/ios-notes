//
//  Category.m
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "Category.h"

@implementation Category

-(Category*) initWithId:(NSNumber*)Id title:(NSString*)title createdDate:(NSDate*)createdDate {
    self = [super init];
    self.Id = Id;
    self.title = title;
    self.createdDate = createdDate;
    
    return self;
}

@end
