//
//  ViewController.m
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "ViewController.h"
#import "AlertInfo.h"

@interface ViewController ()


@end

@implementation ViewController
NSArray *notes;
NSArray *categories;

- (void)viewDidLoad {
    [super viewDidLoad];
    Controller *cont = [[Controller alloc] init];
    [cont loadData];
    notes = [cont getNotes];
    categories = [cont getCategories];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [categories count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Category *category = categories[section];
    return category.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger counter = 0;
    Category *category = categories[section];
    for (Note *note in notes) {
        if ([note.categoryId isEqualToNumber:category.categoryId]) {
            counter ++;
        }
    }
    return counter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"identifier"];
    }
    Category *category = categories[indexPath.section];
    Note *note = [self getNotes:notes ofCategory:category][indexPath.row];
    cell.textLabel.text = note.title;
    return cell;
}

- (NSArray*)getNotes:(NSArray*)notes ofCategory:(Category*)category {
    NSMutableArray *res = [NSMutableArray new];
    for (Note *note in notes) {
        if ([note.categoryId isEqualToNumber:category.categoryId]) {
            [res addObject:note];
        }
    }
    return res;
}


@end
