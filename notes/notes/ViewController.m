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
NSArray *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    Controller *cont = [[Controller alloc] init];
    [cont loadData];
    data = [cont getData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"identifier"];
    }
    cell.textLabel.text = data[indexPath.row];
    return cell;
}

@end
