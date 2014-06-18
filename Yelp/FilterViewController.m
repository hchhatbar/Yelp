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
@property NSUserDefaults *defaults;
@property NSIndexPath* checkedIndexPath;
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
    
    self.defaults = [NSUserDefaults standardUserDefaults];
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
    [button setFrame:CGRectMake(10,20,60,40)];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 4.0f;
    [self.navigationController.view addSubview:button];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchButton setFrame:CGRectMake(250,20,60,40)];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [searchButton setTintColor:[UIColor redColor]];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(cancelClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    searchButton.layer.borderColor = [UIColor clearColor].CGColor;
    searchButton.layer.borderWidth = 1.0f;
    searchButton.layer.cornerRadius = 4.0f;
    [self.navigationController.view addSubview:searchButton];

    
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
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        
       return  [self.collapsed[@(section)] boolValue] ? 1 : 2;
    }
    else if (section == 1)
    {
        return [self.collapsed[@(section)] boolValue] ? 1 : 5;
    }
    else if (section == 2)
    {
        return [self.collapsed[@(section)] boolValue] ? 1 : 3;
    }
    else if (section == 3)
    {
        return [self.collapsed[@(section)] boolValue] ? 1 : 1;
    }
    else if (section == 4)
    {
        return [self.collapsed[@(section)] boolValue] ? 1 : 1;
    }
    else return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
            cell.textLabel.text = @"Offering a Deal";
        else cell.textLabel.text = @"Delivery";
    
    
            UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(250,5,50,50)];
            switchControl.onTintColor = [UIColor redColor];
            [cell.contentView addSubview:switchControl];
    }
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
            cell.textLabel.text = @"Auto";
        else if(indexPath.row == 1)
            cell.textLabel.text = @"0.3";
        else if(indexPath.row == 2)
            cell.textLabel.text = @"1";
         else  if(indexPath.row == 3)
             cell.textLabel.text = @"5";
         else  if(indexPath.row == 4)
             cell.textLabel.text = @"20";


    }
    else if (indexPath.section == 2)
    {
        if(indexPath.row == 0)
            cell.textLabel.text = @"Best Match";
        else if(indexPath.row == 1)
            cell.textLabel.text = @"Distance";
        else if(indexPath.row == 2)
            cell.textLabel.text = @"Highest Rated";
    }

    //else if(indexPath.section == 3)
    //{
    //    cell.textLabel.text = @"Deals";
    //
    //    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(250,5,50,50)];
    //    switchControl.onTintColor = [UIColor redColor];
    //    [cell.contentView addSubview:switchControl];
    //}
    
    else if(indexPath.section == 3)
    {
        cell.textLabel.text = @"Meters";
  
    }
    
    //else
    //{
    //cell.textLabel.text = [NSString stringWithFormat:@"%d - %d", indexPath.section, indexPath.row];
    //}
    return cell;
}

- (UILabel *) newLabelWithTitle:(NSString *)paramTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.text = paramTitle;
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(5,25,100,50);
    [label sizeToFit];
    return label;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *sectionTitle;
    if(section == 0){
        sectionTitle = @"Most Popular";
    }
        else if (section == 1)
    {
        sectionTitle = @"Distance";
    }
    else if (section == 2)
    {
        sectionTitle = @"Sort By";
    }
    else if (section == 3)
    {
        sectionTitle = @"Radius";
    }
//    else if (section == 4)
//    {
//        sectionTitle = @"Radius";
//    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    [view addSubview:[self newLabelWithTitle:(sectionTitle)]];
    return view;
}


- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = [[tableView indexPathsForVisibleRows] indexOfObject:indexPath];
    if (index != NSNotFound) {
        UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSUInteger index = [[tableView indexPathsForVisibleRows] indexOfObject:indexPath];
        
    NSLog(@"%d", indexPath.section);
    if(indexPath.section == 1)
    {
        //if (index != NSNotFound) {
            UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
        //UILabel *textfield = [cell.contentView viewW viewWithTag:@"Distance"];
        
        
        NSLog(@"%@",cell.textLabel.text);
        [self.defaults setValue:cell.textLabel.text forKey:@"radius_filter"];
        
            if ([cell accessoryType] == UITableViewCellAccessoryNone) {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            } else {
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            }
        //}
        //return cell;
    }
        
        if(indexPath.section == 2)
        {
            //if (index != NSNotFound) {
                UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
                    NSLog(@"%@",cell.textLabel.text);
            if([cell.textLabel.text  isEqual: @"Best Match"]){
                [self.defaults setValue:@"0" forKey:@"sort"];
                
            }

            else if ([cell.textLabel.text  isEqual: @"Distance"]){
                
                NSLog(@"got distance");
                [self.defaults setValue:@"1" forKey:@"sort"];
            }
        
            else if ([cell.textLabel.text  isEqual: @"Highest Rated"]){
                NSLog(@"got highest");
                [self.defaults setValue:@"2" forKey:@"sort"];
                
            }
            
                if ([cell accessoryType] == UITableViewCellAccessoryNone) {
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                } else {
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                }
            //}
            //return cell;
        }

        if(indexPath.section == 3)
        {
            //if (index != NSNotFound) {
                UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
                if ([cell accessoryType] == UITableViewCellAccessoryNone) {
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                } else {
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                }
            //}
            //return cell;
        }

}
@end

//NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//[defaults setValue:@"My saved Data" forKey:@"infoString"];
