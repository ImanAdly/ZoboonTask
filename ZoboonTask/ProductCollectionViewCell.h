//
//  ProductCollectionViewCell.h
//  ZoboonTask
//
//  Created by Iman Adly on 3/29/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProductCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productTitle;
@property (strong, nonatomic) IBOutlet UILabel *productNumberOfLikesLabel;

@end
