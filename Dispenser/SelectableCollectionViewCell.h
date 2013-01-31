//
//  SelectableCollectionViewCell.h
//  Bricolage
//
//  Created by Alaric Cole on 9/19/12.
//  Copyright (c) 2012 Alaric. All rights reserved.
//


#import <UIKit/UIKit.h>
#import<QuartzCore/QuartzCore.h>


@interface SelectableCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectionIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *deselectionIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *highlightIndicator;
@property (nonatomic) BOOL isEditing;

-(void)initCommon;
@end
