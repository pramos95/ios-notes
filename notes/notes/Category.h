//
//  Category.h
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface Category : NSObject
-(Category*) initWithId:(NSNumber*)Id title:(NSString*)title createdDate:(NSDate*)createdDate;

@property NSNumber *Id;
@property NSString *title;
@property NSDate *createdDate;

@end

NS_ASSUME_NONNULL_END
