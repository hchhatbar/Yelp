//
//  DisplayCell.h
//  Yelp
//
//  Created by Hemen Chhatbar on 6/15/14.
//  Copyright (c) 2014 Hemen Chhatbar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileLabel;

@end
