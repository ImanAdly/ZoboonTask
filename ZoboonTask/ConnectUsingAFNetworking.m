
//
//  ConnectUsingAFNetworking.m
//  ZoboonTask
//
//  Created by Iman Adly on 3/27/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import "ConnectUsingAFNetworking.h"

@implementation ConnectUsingAFNetworking
static ConnectUsingAFNetworking * iAFNetworkingSingelton;

#pragma mark -Shared Instance
+ (ConnectUsingAFNetworking*)sharedInstance
{
    if(iAFNetworkingSingelton != nil)
    {
        return iAFNetworkingSingelton;
    }
    
    {
        if (iAFNetworkingSingelton == nil)
        {
            iAFNetworkingSingelton = [[ConnectUsingAFNetworking alloc] init];
        }
    }
    
    return iAFNetworkingSingelton;
}
- (void)getProductsFromUrl:(NSString*)urlString page:(NSInteger)pageNumber onCompletion:(void (^)(NSMutableArray *returnResponse))completion {

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%d",urlString,pageNumber]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSMutableArray * responseArray = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:kNilOptions error:nil];
        completion(responseArray);
        
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    
    [operation start];
    
}


@end
