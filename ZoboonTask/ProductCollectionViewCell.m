//
//  ProductCollectionViewCell.m
//  ZoboonTask
//
//  Created by Iman Adly on 3/29/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =[super initWithCoder:aDecoder];
    if (self) {
        [[self contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    }
    return self;
}


-(void)layoutSubviews
{
    [_productImageView setFrame:self.bounds];
    
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    _productImageView.image = nil;
    _productTitle.text = nil;
}


@end
