//
//  ListViewController.m
//  Yelp
//
//  Created by Hemen Chhatbar on 6/15/14.
//  Copyright (c) 2014 Hemen Chhatbar. All rights reserved.
//

#import "ListViewController.h"
#import "YelpClient.h"
#import "DisplayCell.h"
#import "YelpModel.h"
#import <UIImageView+AFNetworking.h>
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";


@interface ListViewController ()
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic,strong) NSMutableArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *displayView;
@property (nonatomic, strong) UITextField *searchBox;
@property YelpModel *yelpModel;

- (void)getBusinesses:(NSString *)searchTerm;
@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            
            
            self.businesses = response[@"businesses"];
            NSLog(@"%@", self.businesses[1]);
                [self.displayView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }

    return self;
    
}

- (void)getBusinesses:(NSString *)searchTerm{


        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        //self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:searchTerm success:^(AFHTTPRequestOperation *operation, id response) {
            
            
            self.businesses = response[@"businesses"];
            NSLog(@"%@", self.businesses[1]);
            [self.displayView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    


- (void)filterClickEvent: (id) sender {
    NSLog(@"%@", @"Filter Pressed");
    
    
    //navigationController.navigationBar.barTintColor = [UIColor redColor];

    FilterViewController *filterViewController = [[FilterViewController alloc] init];
    
    UINavigationController *filterNavigationController = [[UINavigationController alloc] initWithRootViewController:filterViewController];
    filterNavigationController.navigationBar.barTintColor = [UIColor redColor];
    filterViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:filterNavigationController animated:YES completion: nil];
     
}

- (void)addFilterAndSearchBox
{
    UILabel *magnifyingGlass = [[UILabel alloc] init];
    [magnifyingGlass setText:[[NSString alloc] initWithUTF8String:"\xF0\x9F\x94\x8D"]];
    [magnifyingGlass sizeToFit];
    

    self.searchBox = [[UITextField alloc] initWithFrame:
                              CGRectMake(65,20,200,40)];
    self.searchBox.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.searchBox.borderStyle = UITextBorderStyleRoundedRect;
    self.searchBox.font = [UIFont systemFontOfSize:17];
    [self.searchBox setLeftView:magnifyingGlass];
    [self.searchBox setLeftViewMode:UITextFieldViewModeAlways];
    
    [self.navigationController.view addSubview:self.searchBox];
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10,20,50,40)];
    [button setTitle:@"Filter" forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(filterClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 4.0f;
    [self.navigationController.view addSubview:button];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addFilterAndSearchBox];
    self.searchBox.delegate = self;
    
    self.displayView.dataSource = self;
    self.displayView.rowHeight = 130;
    
    [self.displayView registerNib:[UINib nibWithNibName:@"DisplayCell" bundle:nil] forCellReuseIdentifier: @"DisplayCell"];
    
    [self.displayView setDelegate:self];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"You entered %@",self.searchBox.text);
    [self.searchBox resignFirstResponder];
    [self getBusinesses:self.searchBox.text];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.businesses.count;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *index = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    
    self.yelpModel = [MTLJSONAdapter modelOfClass:YelpModel.class fromJSONDictionary:self.businesses[indexPath.row] error:NULL];
    
    DisplayCell *displayCell = [tableView dequeueReusableCellWithIdentifier:@"DisplayCell"];
    
    displayCell.nameLabel.text = [NSString stringWithFormat:@"%@. %@", index, self.yelpModel.name];

    displayCell.addressLabel.text = [NSString stringWithFormat:@"%@, %@", self.yelpModel.address, self.yelpModel.neighborhood];
    displayCell.reviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews",self.yelpModel.reviewCount];
    displayCell.categoryLabel.text = self.yelpModel.category;
    //displayCell.mileLabel.text = @"1.0";
    
    //Asynchronously load the image
    NSURL   *imageURL   = [NSURL URLWithString:self.yelpModel.imageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    UIImage *placeholderImage; // = [UIImage imageNamed:@"yelp_placeholder.png"];
    
    __weak UITableViewCell *weakCell = displayCell;
    
    
    [displayCell.thumbView setImageWithURLRequest:request
                               placeholderImage:placeholderImage
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                            
                                            weakCell.imageView.image = image;
                                            weakCell.imageView.layer.cornerRadius = 15.0;
                                            weakCell.layer.masksToBounds = YES;
                                           
                                            [weakCell setNeedsLayout];

                                            
                                        } failure:nil];
    
    NSURL   *ratingsURL   = [NSURL URLWithString:self.yelpModel.ratingImageURL];
    NSURLRequest *requestRatingImage = [NSURLRequest requestWithURL:ratingsURL];
    
   //__weak UITableViewCell *weakCellRating = displayCell;
    
    
    [displayCell.ratingView setImageWithURLRequest:requestRatingImage
                                 placeholderImage:placeholderImage
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                              
                                              displayCell.ratingView.image = image;
                                              //weakCellRating.imageView.image = image;
                                                                                            
                                              [displayCell setNeedsLayout];
                                              
                                          } failure:nil];
    
    
       return displayCell;
}

@end
