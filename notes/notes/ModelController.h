//
//  ModelController.h
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModelController : NSObject

@property NSMutableArray *notesArray;
@property NSMutableArray *categoriesArray;

+ (ModelController*) getInstance;
- (ModelController*)init;
- (void)loadData;
- (NSArray*)getNotes;
- (NSArray*)getCategories;
+ (NSArray*)getNotes:(NSArray*)notes ofCategory:(Category*)category;
@end

NS_ASSUME_NONNULL_END
