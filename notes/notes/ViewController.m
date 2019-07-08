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
    [self showMessage];
}

-(void)showAlertWithMessage: (AlertInfo*)alert{
    /*UIAlertView *helloWorldAlert = [[UIAlertView alloc] initWithTitle:alert.titulo message:alert.m delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];*/
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"notes" ofType:@"json"];
   
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath];
    NSString *text = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    
    NSDictionary *notes = [dictionary objectForKey:@"notes"];
    NSLog([NSString stringWithFormat:@"%ld",[notes count]]);
    
    for (NSDictionary *note in notes){
        NSString *id = [note objectForKey:@"id"];
        NSLog(@"id: @%",id);
    }
    
    NSLog(@"fin");
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    return cell;
}

@end
