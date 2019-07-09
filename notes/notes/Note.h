//
//  Note.h
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject
-(Note*)initWithId:(NSString*)Id title:(NSString*)title content:(NSString*)content contentDate:(NSDate*)contentDate categoryId:(NSNumber*)categoryId;

@property NSString *Id;
@property NSString *title;
@property NSString *content;
@property NSDate *contentDate;
@property NSNumber *categoryId;

@end

NS_ASSUME_NONNULL_END
