//
//  ViewController.m
//  notes
//
//  Created by Pedro Ramos on 7/2/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "ViewController.h"
#import "AlertInfo.h"

@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ViewController

-(IBAction)showMessage{
     AlertInfo *alert = [[AlertInfo alloc] initWithTitle: @"titulo" message:@"hola mundo"];
    [self showAlertWithMessage:alert];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    Controller *cont = [[Controller alloc] init];
    [cont loadData];
    
}

-(void)showAlertWithMessage: (AlertInfo*)alert{
    /*UIAlertView *helloWorldAlert = [[UIAlertView alloc] initWithTitle:alert.titulo message:alert.m delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];*/
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"notes" ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    
    NSArray *notes = dictionary [@"notes"];
    
    
    for (NSDictionary *note in notes){
        NSString *title = [note objectForKey:@"title"];
        NSLog(@"title: %@",title);
    }
    NSLog(@"fin");
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"identifier"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"algo %d",indexPath.row];
    return cell;
}

@end
