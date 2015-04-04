//
//  Product.h
//  ZoboonTask
//
//  Created by Iman Adly on 3/28/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property (nonatomic , retain) NSString * productImageURL;
@property (assign) NSInteger productLikesCount;
@property (nonatomic , retain) NSString * productTitle;
@property (assign) float imageHeight;

@end
