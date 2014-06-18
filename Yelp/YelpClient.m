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
    NSDictionary *parameters = @{@"term": term, @"location" : @"San Francisco"};
    
    
    NSMutableDictionary * parametersDict = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    
    //[parameters setValue:@"Sunnyvale" forKey:@"location"];
    //[parameters setValue:term forKey:@"term"];
    //[parameters setValue:@"San Francisco" forKey:@"location"];
    
    
    NSString* radius_filter = [[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"];
    NSString* sort = [[NSUserDefaults standardUserDefaults] objectForKey:@"sort"];
    NSLog(@"ns user def");
    NSLog(@"%@", radius_filter);
    if(sort != nil){
        parametersDict[@"sort"] =  [NSString stringWithFormat:@"%@", sort ];
    
    }
    
    //if(radius_filter != nil){
    //    parametersDict[@"radius_filter"] =  [NSString stringWithFormat:@"%@", radius_filter ];
        
    //}
    
    //if(sort !=nil)
    //    [parameters setValue:@"2" forKey:@"sort"];
//    [parameters setValue:@"San Francisco" forKey:@"location"];
   // NSDictionary *str =  [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    return [self GET:@"search" parameters:parametersDict success:success failure:failure];
}



@end
