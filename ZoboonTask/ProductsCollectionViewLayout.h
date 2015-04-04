//
//  ProductsCollectionViewDataSource.h
//  ZoboonTask
//
//  Created by Iman Adly on 3/28/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductCollectionViewCell.h"
@class ProductsCollectionViewLayout;
@protocol ProductsCollectionViewLayoutDelegate <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(ProductsCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface ProductsCollectionViewLayout : UICollectionViewLayout

@end
