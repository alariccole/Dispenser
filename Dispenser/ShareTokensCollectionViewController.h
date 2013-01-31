//
//  ShareTokensCollectionViewController.h
//  Dispenser
//
//  Created by Alaric Cole on 1/30/13.
//  Copyright (c) 2013 Alaric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenCollectionViewCell.h"
#import "AddTokensViewController.h"


@interface ShareTokensCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray * availableTokensArray;

@property (nonatomic, strong) NSMutableArray * dispensedTokensArray;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *actionButton;


- (IBAction)showSharingOptions:(id)sender;
- (IBAction)cancel:(UIStoryboardSegue *)segue;
- (IBAction)done:(UIStoryboardSegue *)segue;

@end
