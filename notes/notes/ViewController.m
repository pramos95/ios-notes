//
//  ViewController.m
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()

@property (weak, nonatomic) NSArray<Note *> *notes;
@property (weak, nonatomic) NSArray<Category *> *categories;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *numberOfRowsForSection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ModelController *cont = [ModelController getInstance];
    [cont loadData:^(NSError * _Nullable error){
        if (!error) {
            [self refeshTableView:cont];
        } else {
            NSLog(@"%@", error.localizedDescription);
            //TODO:dif displey alert
        }
        
    }];
}

- (void)refeshTableView:(ModelController *)cont {
    self.notes = [cont getNotes];
    self.categories = [cont getCategories];
    self.numberOfRowsForSection = [NSMutableArray new];
    for (int section = 0; section < self.categories.count; section++) {
        NSInteger counter = 0;
        Category *category = self.categories[section];
        for (Note *note in self.notes) {
            if ([note.categoryId isEqualToNumber:category.categoryId]) {
                counter ++;
            }
        }
        [self.numberOfRowsForSection addObject:[NSNumber numberWithLong:counter]];
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categories.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categories[section].title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRowsForSection[section].longLongValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Category *category = self.categories[indexPath.section];
    Note *note = [ModelController getNotes:self.notes ofCategory:category][indexPath.row];
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
