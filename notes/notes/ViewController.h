//
//  ViewController.h
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

