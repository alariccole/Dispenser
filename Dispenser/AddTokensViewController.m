//
//  ViewController.m
//  Dispenser
//
//  Created by Alaric Cole on 1/30/13.
//  Copyright (c) 2013 Alaric. All rights reserved.
//

#import "AddTokensViewController.h"

@interface AddTokensViewController ()

@end

@implementation AddTokensViewController

#pragma mark responder
- (BOOL)canBecomeFirstResponder {
	return YES;
}

#pragma mark Text Field Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	[self.textView becomeFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
