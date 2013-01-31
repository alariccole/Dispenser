//
//  ViewController.h
//  Dispenser
//
//  Created by Alaric Cole on 1/30/13.
//  Copyright (c) 2013 Alaric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTokensViewController : UIViewController <UITextFieldDelegate>

//Just paste your tokens into this text view, hit Done, and you're on your way
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
