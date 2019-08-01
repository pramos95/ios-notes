//
//  ViewController.h
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"
#import "Note.h"
#import "NoteCategory.h"
#import "CustomCell.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

