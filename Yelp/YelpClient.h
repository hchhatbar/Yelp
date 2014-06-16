//
//  YelpClient.h
//  Yelp
//
//  Created by Hemen Chhatbar on 6/15/14.
//  Copyright (c) 2014 Hemen Chhatbar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"

// YELP API provides an application token that allows applications to make unauthenticated requests to their search API
@interface YelpClient : BDBOAuth1RequestOperationManager

/*
 This method allows initialization with Consumer Key and accepts the following four parameters
 @consumerKey
 @consumerSecret
 @accessToken
 @accessSecret
 */
- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *) consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
