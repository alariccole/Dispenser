//
//  TokensFlowLayout.m
//  Dispenser
//
//  Created by Alaric Cole on 1/31/13.
//  Copyright (c) 2013 Alaric Cole. All rights reserved.
//

#import "TokensFlowLayout.h"

@implementation TokensFlowLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }

    return self;
}

- (void)setup
{
	self.scrollDirection = UICollectionViewScrollDirectionVertical;
	self.itemSize = (CGSize){145, 110};
	self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
	self.headerReferenceSize = (CGSize){0, 0};
	self.footerReferenceSize = (CGSize){0, 0};
	self.minimumInteritemSpacing = 10;
	self.minimumLineSpacing = 10;

	[self registerNib:[UINib nibWithNibName:@"EmptyTokensDecorationView" bundle:nil] forDecorationViewOfKind:@"EMPTY_TOKENS"];

}



- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
 	
	UICollectionViewLayoutAttributes *emblemAttributes = [UICollectionViewLayoutAttributes
                                                          layoutAttributesForDecorationViewOfKind:@"EMPTY_TOKENS" withIndexPath:indexPath];

	CGSize referenceSizeForDecorationView = [self referenceSizeForDecorationView];
	
	emblemAttributes.frame = CGRectMake(0, 0, referenceSizeForDecorationView.width, referenceSizeForDecorationView.height);
	
	emblemAttributes.zIndex = 500;
	emblemAttributes.center = self.collectionView.center;
	//emblemAttributes.hidden = YES;
	return emblemAttributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
	 NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
	
	NSMutableArray* arr = [super layoutAttributesForElementsInRect:rect].mutableCopy;

	UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForDecorationViewOfKind:@"EMPTY_TOKENS" atIndexPath:indexPath];

	[arr addObject:attributes];


	return arr.copy;
}


- (CGSize)referenceSizeForDecorationView
{
	if ( [_delegate respondsToSelector:@selector(referenceSizeForDecorationView)] ) {
		return [_delegate referenceSizeForDecorationView];
	}

	return CGSizeZero;

}
@end
