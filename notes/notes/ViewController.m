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
    NSError *error = nil;
    
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSString *text = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    
    self.textArea.text=text;
    

}

@end
