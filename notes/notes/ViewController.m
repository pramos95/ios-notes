//
//  ViewController.m
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "ViewController.h"
#import "notes-Swift.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray<Note *> *notes;
@property (strong, nonatomic) NSArray<NoteCategory *> *categories;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *numberOfRowsForSection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.label.text = @"Loading...";
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    ModelController *cont = [ModelController getInstance];
    [cont loadData:^(NSError * _Nullable error){
        if (!error) {
            [self refeshTableView:cont];
        } else {
            [self showError:error];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)refeshTableView:(ModelController *)cont {
    self.notes = [cont getNotes];
    self.categories = [cont getCategories];
    self.numberOfRowsForSection = [NSMutableArray new];
    for (int section = 0; section < self.categories.count; section++) {
        NSInteger counter = 0;
        NoteCategory *category = self.categories[section];
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
    NoteCategory *category = self.categories[indexPath.section];
    Note *note = [ModelController Notes:self.notes ofCategory:category][indexPath.row];
    cell.title.text = note.title;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"EEEE, MMM d, yyyy";
    cell.date.text = [HelperClass formatDateWithDate: note.contentDate];
    cell.content.text = note.content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    detailView.note = [ModelController Notes:self.notes ofCategory:self.categories[indexPath.section]][indexPath.row];
    detailView.category = self.categories[indexPath.section];

    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)showError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Download Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:dismissAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

@end
