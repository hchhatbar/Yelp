//
//  YelpModel.m
//  Yelp
//
//  Created by Hemen Chhatbar on 6/15/14.
//  Copyright (c) 2014 Hemen Chhatbar. All rights reserved.
//

#import "YelpModel.h"

@interface YelpModel()


@end

//@property (strong, nonatomic) NSString *thumbURL;

@implementation YelpModel


+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{@"name"  : @"name",
             @"address"  : @"location.address",
             @"neighborhood" : @"location.neighborhoods",
             @"imageURL" : @"image_url",
             @"ratingImageURL" : @"rating_img_url",
             @"reviewCount" : @"review_count",
             @"category" : @"categories",
             };
 
}



+ (NSValueTransformer *)categoryJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSDictionary *categoryArray)
            {
                NSLog(@"%@",categoryArray);
                
                NSString *categoryString; // = [NSDictionary componentsJoinedByString:@", "];
                //NSLog(@"%@",categoryString);

                return categoryString;
            }];
}


+ (NSValueTransformer *)addressJSONTransformer
{
        return [MTLValueTransformer reversibleTransformerWithBlock:^(NSArray *addressArray)
            {
                NSString *joinedString = [addressArray componentsJoinedByString:@" "];
                return joinedString;
            }];
}

+ (NSValueTransformer *)neighborhoodJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSArray *neighborhoodArray)
            {
                NSString *joinedString = [neighborhoodArray componentsJoinedByString:@" "];
                return joinedString;
            }];
}


@end
