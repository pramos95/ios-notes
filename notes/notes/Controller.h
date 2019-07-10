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

@property NSMutableArray *notesArray;
@property NSMutableArray *categoriesArray;

- (Controller*)init;
- (void)loadData;
- (NSArray*)getData;

@end

NS_ASSUME_NONNULL_END
