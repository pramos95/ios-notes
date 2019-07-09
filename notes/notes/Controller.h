//
//  Controller.h
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface Controller : NSObject

@property NSMutableArray<Note*> *notes;
@property NSMutableArray<Category*> *categories;

- (Controller*)init;
- (void)loadData;

@end

NS_ASSUME_NONNULL_END
