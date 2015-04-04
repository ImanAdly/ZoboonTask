
//
//  ProductsCollectionViewDataSource.m
//  ZoboonTask
//
//  Created by Iman Adly on 3/28/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import "ProductsCollectionViewLayout.h"
@interface ProductsCollectionViewLayout ()

@property (strong, nonatomic) NSMutableArray *itemAttributes;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) UIOffset itemOffset;
@property (nonatomic, weak) id<ProductsCollectionViewLayoutDelegate> delegate;

@end
@implementation ProductsCollectionViewLayout
static int heightForActivityIndicator = 60;
int heightAtEvenItem,heightAtOddItem;
-(void)prepareCustomDelegate
{
    if (!_delegate && [self.collectionView.delegate conformsToProtocol:@protocol(ProductsCollectionViewLayoutDelegate)]) {
        _delegate = (id<ProductsCollectionViewLayoutDelegate>)self.collectionView.delegate;
    }
}

#pragma mark - UICollectionViewDataSource



-(void)prepareLayout
{
    [super prepareLayout];
    heightAtEvenItem = 0;
    heightAtOddItem = 0;
    [self prepareCustomDelegate];
    [self setItemOffset:UIOffsetMake(5.0, 5.0)];
    _itemAttributes = [[NSMutableArray alloc] init];
    
    NSUInteger column = 0;
    CGFloat yOffset = _itemOffset.vertical;
    CGFloat rowHeight = 0.0;
    
    CGFloat contentHeight = 0.0;
    NSUInteger numberOfColumnsInRow = 2;
    
    NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    for (int index = 0; index < numberOfItems; index++)
    {
        CGSize cellSize;
        
     NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        
        if([_delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]){
           
            cellSize = [_delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            if (cellSize.height > rowHeight)
                rowHeight = cellSize.height;
            

            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            [attributes setFrame:[self frameForIndexPath:indexPath size:cellSize ]];
            
            [_itemAttributes addObject:attributes];
        
        }
        
        column++;
        
        if (column == numberOfColumnsInRow)
        {
            column = 0;
            yOffset += rowHeight+_itemOffset.vertical;
            numberOfColumnsInRow = 2;
        }
    }
    
    // Get the last item to calculate the total height of the content
    UICollectionViewLayoutAttributes *attributes = [_itemAttributes lastObject];
    contentHeight = attributes.frame.origin.y+attributes.frame.size.height;
    
    // Return this in collectionViewContentSize
    _contentSize = CGSizeMake(self.collectionView.frame.size.width, contentHeight+heightForActivityIndicator);
}

-(CGSize)collectionViewContentSize
{
    return _contentSize;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_itemAttributes objectAtIndex:indexPath.row];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [_itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}



-(CGRect)frameForIndexPath:(NSIndexPath*)indexPath size:(CGSize)cellSize
{
 
    CGRect  cellFrame ;
    if(indexPath.item %2)
    {

        
      cellFrame =  CGRectMake(cellSize.width/2+_itemOffset.horizontal, heightAtEvenItem,cellSize.width/2-_itemOffset.horizontal, cellSize.height/2);
         heightAtEvenItem = heightAtEvenItem + cellSize.height/2 + _itemOffset.vertical;
        
    }
    else
    {
     
      cellFrame =  CGRectMake(_itemOffset.horizontal, heightAtOddItem, cellSize.width/2-_itemOffset.horizontal, cellSize.height/2);

        heightAtOddItem = heightAtOddItem + cellSize.height/2 + _itemOffset.vertical;
        
    }

    return cellFrame;

}


@end
