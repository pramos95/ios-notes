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
    UIAlertView *helloWorldAlert = [[UIAlertView alloc] initWithTitle:alert.titulo message:alert.m delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    NSFileManager *fileMgr = [NSFileManager defaultManager ];
    if ([fileMgr fileExistsAtPath:@"/notes.json"]) {
       [helloWorldAlert show];
        NSLog(@"encontrado");
    }else{
        NSLog(@"no encontrado");
    }

    
    
}

@end
