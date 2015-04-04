//
//  ConnectUsingAFNetworking.h
//  ZoboonTask
//
//  Created by Iman Adly on 3/27/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"


@interface ConnectUsingAFNetworking : NSObject
+ (ConnectUsingAFNetworking*)sharedInstance;
- (void)getProductsFromUrl:(NSString*)urlString page:(NSInteger)pageNumber onCompletion:(void (^)(NSMutableArray *returnResponse))completion;
@end
