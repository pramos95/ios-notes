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
    ModelController *cont = [ModelController getInstance];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reciveRefeshNotification:) name:nil object:cont];
    [cont loadData:^(NSError * _Nullable error){
        if (!error) {
            [self refeshTableView:cont];
        } else {
            [self showError:error];
        }
    }];
}

- (void)reciveRefeshNotification:(NSNotification *)notification {
    ModelController *cont = [ModelController getInstance];
    [self refeshTableView:cont];
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
    Note *note = [ModelController notes:self.notes ofCategory:category][indexPath.row];
    cell.title.text = note.title;
    cell.date.text = [HelperClass formatDateWithDate: note.contentDate];
    cell.content.text = note.content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    detailView.note = [ModelController notes:self.notes ofCategory:self.categories[indexPath.section]][indexPath.row];
    detailView.category = self.categories[indexPath.section];
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
        AddEditNoteViewController *editView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddEditNoteViewController"];
        NoteCategory *category = self.categories[indexPath.section];
        editView.note = [ModelController notes:self.notes ofCategory:category][indexPath.row];
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
    AddEditNoteViewController *addNoteView = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddEditNoteViewController"];
    [[self navigationController] pushViewController:addNoteView animated:YES];
}
@end
