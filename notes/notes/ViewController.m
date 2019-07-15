//
//  ViewController.m
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController () {
    
}
@end

@implementation ViewController
NSArray<Note*> *notes;
NSArray<Category*> *categories;
NSMutableArray<NSNumber*> *numberOfRowsForSection;

- (void)viewDidLoad {
    [super viewDidLoad];
    ModelController *cont = [ModelController getInstance];
    [cont loadData];
    notes = [cont getNotes];
    categories = [cont getCategories];
    numberOfRowsForSection = [NSMutableArray new];
    for (int section = 0; section < categories.count; section++) {
        NSInteger counter = 0;
        Category *category = categories[section];
        for (Note *note in notes) {
            if ([note.categoryId isEqualToNumber:category.categoryId]) {
                counter ++;
            }
        }
        [numberOfRowsForSection addObject:[NSNumber numberWithLong:counter]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return categories.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return categories[section].title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfRowsForSection[section].longLongValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Category *category = categories[indexPath.section];
    Note *note = [ModelController getNotes:notes ofCategory:category][indexPath.row];
    cell.title.text = note.title;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"EEEE, MMM d, yyyy";
    cell.date.text = [dateFormatter stringFromDate:note.contentDate];
    cell.content.text = note.content;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

@end
