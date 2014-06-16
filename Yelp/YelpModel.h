//
//  YelpModel.h
//  Yelp
//
//  Created by Hemen Chhatbar on 6/15/14.
//  Copyright (c) 2014 Hemen Chhatbar. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "Mantle/Mantle.h"

@interface YelpModel : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *neighborhood;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *ratingImageURL;
@property (strong, nonatomic) NSString *reviewCount;

@end
