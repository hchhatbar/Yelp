//
//  YelpClient.m
//  Yelp
//
//  Created by Hemen Chhatbar on 6/15/14.
//  Copyright (c) 2014 Hemen Chhatbar. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *parameters = @{@"term": term}; //, @"location" : @"San Francisco"};
    
    
    NSMutableDictionary * parametersDict = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    
    
    NSString *radius_filter = [[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"];
    NSString *sort = [[NSUserDefaults standardUserDefaults] objectForKey:@"sort"];
    NSString *deals = [[NSUserDefaults standardUserDefaults] objectForKey:@"deals_filter"];
    NSLog(@"ns user def");
    NSLog(@"%@", deals);
    if(sort != nil)
        parametersDict[@"sort"] =  sort ; //[NSString stringWithFormat:@"%@", sort ];
    if(deals != nil)
        parametersDict[@"deals_filter"] =  deals ;
    if(radius_filter != nil)
    {
        if([radius_filter  isEqual: @"Auto"])
            radius_filter = @"500";
        else
            parametersDict[@"radius_filter"] = radius_filter; //[NSString stringWithFormat:@"%@", radius_filter ];
    }
    
    parametersDict[@"ll"] = @"37.788022,-122.399797"; //[NSString stringWithFormat:@"%@", radius_filter ];
    
    
    return [self GET:@"search" parameters:parametersDict success:success failure:failure];
}



@end
