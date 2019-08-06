//
//  ModelController.h
//  notes
//
//  Created by Pedro Ramos on 7/9/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModelController : NSObject

extern NSString *const refeshNotificationName;
@property (strong, nonatomic) NSMutableArray<Note *> *notesArray;
@property (strong, nonatomic) NSMutableArray<NoteCategory *> *categoriesArray;

+ (ModelController *)sharedInstance;
- (void)loadData:(void (^)(NSError * _Nullable error))completionHandler;
- (NSArray<Note *> *)getNotes;
- (NSArray<NoteCategory *> *)getCategories;
- (NoteCategory *)categoryWithId:(NSNumber *)categoryId;
- (NSArray<Note *> *)notesOfCategory:(NoteCategory *)category;
- (void)addNote:(Note *)note;
- (void)editNote:(Note *)current withModifiedNote:(Note *)modifiedNote;

@end

NS_ASSUME_NONNULL_END
