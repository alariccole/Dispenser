//
//  SelectableCollectionViewCell.m
//  Bricolage
//
//  Created by Alaric Cole on 9/19/12.
//  Copyright (c) 2012 Alaric. All rights reserved.
//

#import "SelectableCollectionViewCell.h"


@implementation SelectableCollectionViewCell




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
	}
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
        [self initCommon];
	}
    return self;

}
-(void)initCommon
{

}
-(void)setIsEditing:(BOOL)isEditing
{
	_isEditing = isEditing;

	[self showOrHideSelection];


}
-(void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	self.highlightIndicator.hidden = !highlighted;


}

-(void)showOrHideSelection
{
	if(_isEditing)
	{
		self.selectionIndicator.hidden = !self.selected;
		self.deselectionIndicator.hidden = self.selected;

	}
	else{
		self.selectionIndicator.hidden = YES;
		self.deselectionIndicator.hidden = YES;

	}

}
-(void)setSelected:(BOOL)selected
{
	[super setSelected:selected];

	[self showOrHideSelection];


}

-(void)prepareForReuse
{
	[super prepareForReuse];

	[self showOrHideSelection];
}
@end
