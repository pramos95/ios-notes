//
//  ViewController.h
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>¡

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

extern NSString *const addEditNoteViewName;
extern NSString *const detailViewName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNote;

- (IBAction)addNoteAction:(UIBarButtonItem *)sender;

@end

