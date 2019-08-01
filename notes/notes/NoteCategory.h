//
//  Category.h
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NoteCategory : NSObject
- (NoteCategory *)initWithId:(NSNumber *)categoryId title:(NSString *)title createdDate:(NSDate *)createdDate;

@property (strong, nonatomic) NSNumber *categoryId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *createdDate;

@end

NS_ASSUME_NONNULL_END
