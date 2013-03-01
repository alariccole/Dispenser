//
//  TokensFlowLayout.h
//  Dispenser
//
//  Created by Alaric Cole on 1/31/13.
//  Copyright (c) 2013 Alaric Cole. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CollectionViewDelegateTokensFlowLayout <UICollectionViewDelegateFlowLayout>
@optional
- (CGSize)referenceSizeForDecorationView;
@end

@interface TokensFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak)id <CollectionViewDelegateTokensFlowLayout> delegate;
@end
