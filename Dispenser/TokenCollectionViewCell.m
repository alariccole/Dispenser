//
//  TokenCollectionViewCell.m
//  Dispenser
//
//  Created by Alaric Cole on 1/30/13.
//  Copyright (c) 2013 Alaric. All rights reserved.
//

#import "TokenCollectionViewCell.h"

@implementation TokenCollectionViewCell

-(void)initCommon
{
	[super initCommon];

	self.layer.borderColor = [UIColor whiteColor].CGColor;
	self.layer.borderWidth = 5.0f;
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowRadius = 3.0f;
	self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
	self.layer.shadowOpacity = 0.5f;

	self.layer.rasterizationScale = [UIScreen mainScreen].scale;
	self.layer.shouldRasterize = YES;

	self.layer.cornerRadius = 3.5;
	self.layer.masksToBounds = NO;

	self.isDispensed = NO;
}

-(void)setSelected:(BOOL)selected
{
	[super setSelected:selected];

	self.label.textColor = selected? [UIColor clearColor] : [UIColor lightTextColor];
	self.label.shadowColor = selected? [UIColor whiteColor] : [UIColor lightGrayColor];
}

-(void)setIsDispensed:(BOOL)isDispensed
{
	_isDispensed = isDispensed;
	
	//self.label.textColor = _isDispensed? [UIColor clearColor] : [UIColor lightTextColor];
	if (_isDispensed) {
		//self.label.shadowColor = [UIColor clearColor];

		self.backgroundColor = [UIColor colorWithHue:1.0 saturation:0. brightness:.85 alpha:1.0];
//		self.layer.shadowRadius = 1.0f;
//		self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
	}

	else
	{
		self.backgroundColor = [UIColor colorWithHue:1.0 saturation:0. brightness:.93 alpha:1.0];
	}
}

-(void)prepareForReuse
{
	[super prepareForReuse];
	
	self.label.text = @"";
	//self.isDispensed = NO;
//	self.layer.shadowRadius = 0.0f;
//	self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}
@end
