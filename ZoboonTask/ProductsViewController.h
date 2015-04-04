//
//  ViewController.h
//  ZoboonTask
//
//  Created by Iman Adly on 3/25/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectUsingAFNetworking.h"
#import "ProductsCollectionViewLayout.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProductsViewController : UIViewController <UICollectionViewDataSource , UICollectionViewDelegate , ProductsCollectionViewLayoutDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

