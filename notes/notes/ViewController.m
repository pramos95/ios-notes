//
//  ViewController.m
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "ViewController.h"
#import "notes-Swift.h"
#import "ModelController.h"
#import "Note.h"
#import "NoteCategory.h"
#import "CustomCell.h"
#import "MBProgressHUD.h"

NSString *const addEditNoteViewName = @"AddEditNoteViewController";
NSString *const detailViewName = @"DetailView";

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
    ModelController *cont = [ModelController sharedInstance];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reciveRefeshNotification:) name:refeshNotificationName object:cont];
    [cont loadData:^(NSError * _Nullable error){
        if (!error) {
            [self refeshTableView];
        } else {
            [self showError:error];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)reciveRefeshNotification:(NSNotification *)notification {
    [self refeshTableView];
}

- (void)refeshTableView {
    ModelController *cont = [ModelController sharedInstance];
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
    Note *note = [[ModelController sharedInstance] notesOfCategory:category][indexPath.row];
    cell.title.text = note.title;
    cell.date.text = [HelperClass formatDateWithDate: note.contentDate];
    cell.content.text = note.content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:detailViewName];
    detailView.note = [[ModelController sharedInstance] notesOfCategory:self.categories[indexPath.section]][indexPath.row];
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)showError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Download Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:dismissAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        AddEditNoteViewController *editView = [self.storyboard instantiateViewControllerWithIdentifier:addEditNoteViewName];
        NoteCategory *category = self.categories[indexPath.section];
        editView.note = [[ModelController sharedInstance] notesOfCategory:category][indexPath.row];
        [self.navigationController pushViewController:editView animated:YES];
    }];
    NSMutableArray *actions = [NSMutableArray new];
    [actions addObject:action];
    return [UISwipeActionsConfiguration configurationWithActions:actions];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (IBAction)addNoteAction:(UIBarButtonItem *)sender {
    AddEditNoteViewController *addNoteView = [self.storyboard instantiateViewControllerWithIdentifier:addEditNoteViewName];
    [self.navigationController pushViewController:addNoteView animated:YES];
}

- (IBAction)addCategoryAction:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Category" message:@"Insert category title" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text.length == 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300, 100)];
            label.text = @"Category title cannot be empty";
            label.textColor = UIColor.redColor;
            [alert.view addSubview:label];
            [self presentViewController:alert animated:YES completion:nil];
        }else {
            [[ModelController sharedInstance] addCategoryWithTitle:alert.textFields[0].text];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
