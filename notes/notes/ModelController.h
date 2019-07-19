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

@property (strong, nonatomic) NSMutableArray<Note *> *notesArray;
@property (strong, nonatomic) NSMutableArray<Category *> *categoriesArray;

+ (ModelController *)getInstance;
- (ModelController *)init;
- (void)loadData:(void (^)(NSError * _Nullable error))completionHandler;
- (NSArray *)getNotes;
- (NSArray *)getCategories;
+ (NSArray *)getNotes:(NSArray *)notes ofCategory:(Category *)category;

@end

NS_ASSUME_NONNULL_END
