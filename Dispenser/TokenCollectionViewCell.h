//
//  TokenCollectionViewCell.h
//  Dispenser
//
//  Created by Alaric Cole on 1/30/13.
//  Copyright (c) 2013 Alaric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectableCollectionViewCell.h"
@interface TokenCollectionViewCell : SelectableCollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (nonatomic) BOOL isDispensed;
@end
