//
//  notesTests.m
//  notesTests
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NoteCategory.h"
#import "ModelController.h"
#import "Note.h"

@interface notesTests : XCTestCase

@property ModelController *cont;

@end

@implementation notesTests

- (void)setUp {
    self.cont = [ModelController sharedInstance];
}

- (void)tearDown {
    
}

- (void)testNoteInit {
    NSString *noteId = @"";
    NSString *title = @"un titulo";
    NSString *content = @"sihfjifj";
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:10];
    NSNumber *categoryId = [NSNumber numberWithInt:0];
    Note *note = [[Note alloc] initWithId:noteId title:title content:content contentDate:createdDate categoryId:categoryId];
    
    XCTAssertTrue([note.noteId isEqualToString:noteId]);
    XCTAssertTrue([note.title isEqualToString:title]);
    XCTAssertTrue([note.content isEqualToString:content]);
    XCTAssertTrue([note.contentDate isEqualToDate:createdDate]);
    XCTAssertTrue([note.categoryId isEqualToNumber:categoryId]);
}

- (void)testNoteCategoryInit {
    NSNumber *categoryId = [NSNumber numberWithInt:0];
    NSString *title = @"un titulo";
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:10];
    NoteCategory *cat = [[NoteCategory alloc] initWithId:categoryId title:title createdDate:createdDate];
    XCTAssertTrue([cat.categoryId isEqualToNumber:categoryId]);
    XCTAssertTrue([cat.title isEqualToString:title]);
    XCTAssertTrue([cat.createdDate isEqualToDate:createdDate]);
}

- (void)testLoadData {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    [self.cont loadData:^(NSError * _Nullable error) {
        XCTAssertTrue(self.cont.notesArray.count != 0);
        XCTAssertTrue(self.cont.categoriesArray.count != 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.001 handler:nil];
}

- (void)testAddNote {
    NSString *noteId = @"";
    NSString *title = @"un titulo";
    NSString *content = @"sihfjifj";
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:10];
    NSNumber *categoryId = [NSNumber numberWithInt:0];
    Note *note = [[Note alloc] initWithId:noteId title:title content:content contentDate:createdDate categoryId:categoryId];
    
    [self.cont addNote:note];
    XCTAssertTrue([self.cont.notesArray containsObject:note]);
}

- (void)testEditNote {
    NSString *noteId = @"";
    NSString *title = @"un titulo";
    NSString *content = @"sihfjifj";
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:10];
    NSNumber *categoryId = [NSNumber numberWithInt:0];
    Note *note = [[Note alloc] initWithId:noteId title:title content:content contentDate:createdDate categoryId:categoryId];
    
    [self.cont addNote:note];
    
    NSString *otherNoteId = @"";
    NSString *otherTitle = @"otro titulo";
    NSString *otherContent = @"sihfjifj";
    NSDate *otherCreatedDate = [NSDate dateWithTimeIntervalSince1970:10];
    NSNumber *otherCategoryId = [NSNumber numberWithInt:0];
    Note *otherNote = [[Note alloc] initWithId:otherNoteId title:otherTitle content:otherContent contentDate:otherCreatedDate categoryId:otherCategoryId];
    
    [self.cont editNote:note withModifiedNote:otherNote];
    
    XCTAssertTrue([self.cont.notesArray containsObject:otherNote]);
    XCTAssertTrue(![self.cont.notesArray containsObject:note]);
}
@end
