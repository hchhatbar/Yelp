//
//  FilterViewController.m
//  Yelp
//
//  Created by Hemen Chhatbar on 6/16/14.
//  Copyright (c) 2014 Hemen Chhatbar. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (nonatomic,strong) NSMutableDictionary * collapsed;

- (UILabel *) newLabelWithTitle:(NSString *)paramTitle;

@end


@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.collapsed = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addCancelAndSearchButtons];
    
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;
    
}

- (void)addCancelAndSearchButtons
{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10,20,50,40)];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 4.0f;
    [self.navigationController.view addSubview:button];
    
}

- (void)cancelClickEvent: (id) sender {
    NSLog(@"%@", @"Cancel Pressed");
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        
       return  [self.collapsed[@(section)] boolValue] ? 1 : 2;
    }
    else
    {
    return [self.collapsed[@(section)] boolValue] ? 1 : 3;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(indexPath.section == 0)
    {
            cell.textLabel.text = @"Most Popular";
            UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(250,5,50,50)];
            [cell.contentView addSubview:switchControl];
    }
    else
    {
    cell.textLabel.text = [NSString stringWithFormat:@"%d - %d", indexPath.section, indexPath.row];
    }
    return cell;
}

- (UILabel *) newLabelWithTitle:(NSString *)paramTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = paramTitle;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    return label;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *sectionTitle;
    if(section == 0){
        sectionTitle = @"Price";
    }
    else if (section == 1)
    {
        sectionTitle = @"Most Popular";
    }
    else if (section == 2)
    {
        sectionTitle = @"Distance";
    }
    else if (section == 3)
    {
        sectionTitle = @"Sort By";
    }
    else if (section == 4)
    {
        sectionTitle = @"Deals";
    }
    else if (section == 5)
    {
        sectionTitle = @"Radius";
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    view.backgroundColor = [UIColor grayColor];
    
    [view addSubview:[self newLabelWithTitle:(sectionTitle)]];
    return view;
}

//- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Most P";
//}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //int section = indexPath.section;
    self.collapsed[@(indexPath.section)] = @(![self.collapsed[@(indexPath.section)] boolValue]);
    
    [self.filterTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]withRowAnimation:UITableViewRowAnimationAutomatic];
      
      //[self.filterTableView reloadData];
}
@end
