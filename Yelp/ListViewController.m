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

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";


@interface ListViewController ()
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic,strong) NSMutableArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *displayView;
@property YelpModel *yelpModel;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    self.displayView.dataSource = self;
    self.displayView.rowHeight = 130;
    
    [self.displayView registerNib:[UINib nibWithNibName:@"DisplayCell" bundle:nil] forCellReuseIdentifier: @"DisplayCell"];
    
    [self.displayView setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.yelpModel = [MTLJSONAdapter modelOfClass:YelpModel.class fromJSONDictionary:self.businesses[indexPath.row] error:NULL];
    
    
    DisplayCell *displayCell = [tableView dequeueReusableCellWithIdentifier:@"DisplayCell"];
    
    displayCell.nameLabel.text = self.yelpModel.name;
    //displayCell.typeLabel.text = self.yelpModel.category;
    displayCell.addressLabel.text = [NSString stringWithFormat:@"%@, %@", self.yelpModel.address, self.yelpModel.neighborhood];
    displayCell.mileLabel.text = @"1.0";
    
    return displayCell;
}

@end
