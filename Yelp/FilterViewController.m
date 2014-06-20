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
@property (nonatomic, strong) NSString *deals;
@property (nonatomic, strong) NSString *radius;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSMutableDictionary *categoryDict;




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
    self.categoryDict = [[NSMutableDictionary alloc] init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self addCancelAndSearchButtons];
    //NSMutableDictionary *tempCategoryDict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary* tempCategoryDict = [[self.defaults objectForKey:@"category_dict"] mutableCopy];
    
    //tempCategoryDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"category_dict"];
    
    if (tempCategoryDict != nil)
    {
        self.categoryDict = tempCategoryDict;
        for (id key in tempCategoryDict) {
            NSLog(@"key: %@, value: %@ \n", key, [tempCategoryDict objectForKey:key]);
            //[categories appendFormat:@"%@,",[self.categoryDict objectForKey:key]];
        }
    }
    

    
    self.deals = [[NSUserDefaults standardUserDefaults] objectForKey:@"deals_filter"];
    self.radius = [[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"];
    self.sort = [[NSUserDefaults standardUserDefaults] objectForKey:@"sort"];
    
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
    [searchButton addTarget:self action:@selector(searchClickEvent:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)searchClickEvent: (id) sender {
    NSLog(@"%@", @"Search Pressed");
    
    //for (NSString* key in self.categoryDict) {
    //    id value = [self.categoryDict objectForKey:key];
    //    NSLog(@"%@", value);
    //}
    NSMutableString *categories = [[NSMutableString alloc]init];
    
    for (id key in self.categoryDict) {
        NSLog(@"key: %@, value: %@ \n", key, [self.categoryDict objectForKey:key]);
        [categories appendFormat:@"%@,",[self.categoryDict objectForKey:key]];
    }
    [categories deleteCharactersInRange:NSMakeRange([categories length]-1, 1)];
    NSLog(@"%@",categories);
    
    [self.defaults setObject:self.categoryDict forKey:@"category_dict"];
    [self.defaults setValue:categories forKey:@"category_filter"];
    [self.defaults setValue:self.deals forKey:@"deals_filter"];
    [self.defaults setValue:self.radius forKey:@"radius_filter"];
    [self.defaults setValue:self.sort forKey:@"sort"];
    
    
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
        
       return  [self.collapsed[@(section)] boolValue] ? 1 : 1;
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
        return [self.collapsed[@(section)] boolValue] ? 1 : 3;
    }
    else if (section == 4)
    {
        return [self.collapsed[@(section)] boolValue] ? 1 : 1;
    }
    else return 1;
}

-(void) switchStateChanged:(id)sender
{
    NSLog(@"swt");
    BOOL state = [sender isOn];
    if (state) {

            self.deals = @"true";
//        [self.defaults setValue:@"true" forKey:@"deals_filter"];

        } else {
//        [self.defaults setValue:@"false" forKey:@"deals_filter"];
            self.deals = @"false";
            
            NSLog(@"%hhd",state);
            
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
            cell.textLabel.text = @"Offering a Deal";
        //else cell.textLabel.text = @"Delivery";
    
        NSString *selectedState = self.deals;//[[NSUserDefaults standardUserDefaults] objectForKey:@"deals_filter"];
        NSLog(@"%@d",selectedState);

    
            UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(250,5,50,50)];
            switchControl.onTintColor = [UIColor redColor];
        [switchControl addTarget:self
                       action:@selector(switchStateChanged:)
             forControlEvents:UIControlEventValueChanged];
        if([selectedState isEqual:@"true"])
            [switchControl setOn:YES];
            [cell.contentView addSubview:switchControl];
    }
    else if (indexPath.section == 1)
    {
        
        
        if([self.collapsed[@(indexPath.section)] boolValue])
        {
            NSString *distance = self.radius;// [[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"];
            NSString *cellLabelText = @"Auto";
            
            if ([distance isEqual:@"1600"])
                cellLabelText = @"1";
            else if ([distance isEqual:@"8000"])
                cellLabelText = @"5";

            else if ([distance isEqual:@"32000"])
                cellLabelText = @"20";


            cell.textLabel.text = cellLabelText;
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            
        }
        else
        {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"Auto";
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"]  isEqual: @"500"])
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"0.3";
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"]  isEqual: @"500"])
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = @"1";
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"]  isEqual: @"1600"])
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
         else  if(indexPath.row == 3)
         {
             cell.textLabel.text = @"5";
             if([[[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"]  isEqual: @"8000"])
                 [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
         }
         else  if(indexPath.row == 4)
         {
             cell.textLabel.text = @"20";
             if([[[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"]  isEqual: @"32000"])
                 [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
         }
        }
        
        
    }
    else if (indexPath.section == 2)
    {
        if([self.collapsed[@(indexPath.section)] boolValue])
        {
            
            NSString *sort = self.sort;//[[NSUserDefaults standardUserDefaults] objectForKey:@"sort"];
            NSString *cellLabelText = @"Best Match";
            
            if ([sort isEqual:@"0"])
                cellLabelText = @"Best Match";
            else if ([sort isEqual:@"1"])
                cellLabelText = @"Distance";
            
            else if ([sort isEqual:@"2"])
                cellLabelText = @"Highest Rated";
            
            
            cell.textLabel.text = cellLabelText;
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            

            
        }
        else
        {

        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"Best Match";
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sort"]  isEqual: @"0"])
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"Distance";
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sort"]  isEqual: @"1"])
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];

        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = @"Highest Rated";
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sort"]  isEqual: @"2"])
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];

        }
        }
    }

    
    else// if(indexPath.section == 3)
    {
        //cell.textLabel.text = @"Meters";
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"American";
            //if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sort"]  isEqual: @"0"])
            if([self.categoryDict objectForKey:@"American"] != nil)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"Indian";
            if([self.categoryDict objectForKey:@"Indian"] != nil)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = @"Thai";
            if([self.categoryDict objectForKey:@"Thai"] != nil)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            
        }
    
  
    }
    
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
        sectionTitle = @"Category";
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    [view addSubview:[self newLabelWithTitle:(sectionTitle)]];
    return view;
}


- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"delect called");
    if(!(indexPath.section == 3))
    {
    NSUInteger index = [[tableView indexPathsForVisibleRows] indexOfObject:indexPath];
    if (index != NSNotFound) {
        UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    }
}



    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSUInteger index = [[tableView indexPathsForVisibleRows] indexOfObject:indexPath];

        if(indexPath.section == 1)
    {
        
        UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
        NSString *distance = @"500";
        if ([cell.textLabel.text isEqual:@"1"])
            distance = @"1600";
        else if ([cell.textLabel.text isEqual:@"5"])
            distance = @"8000";
        else if ([cell.textLabel.text isEqual:@"20"])
            distance = @"32000";
        
        self.radius = distance;
        //[self.defaults setValue:distance forKey:@"radius_filter"];
        
            if ([cell accessoryType] == UITableViewCellAccessoryNone) {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            } else {
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            }
        
        self.collapsed[@(indexPath.section)] = @(![self.collapsed[@(indexPath.section)] boolValue]);
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];

    }
        
        if(indexPath.section == 2)
        {

            UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
            
            if([cell.textLabel.text  isEqual: @"Best Match"]){
                //[self.defaults setValue:@"0" forKey:@"sort"];
                self.sort = @"0";
                
            }

            else if ([cell.textLabel.text  isEqual: @"Distance"]){
                
                NSLog(@"got distance");
                //[self.defaults setValue:@"1" forKey:@"sort"];
                self.sort = @"1";
            }
        
            else if ([cell.textLabel.text  isEqual: @"Highest Rated"]){
                NSLog(@"got highest");
                //[self.defaults setValue:@"2" forKey:@"sort"];
                self.sort = @"2";
                
            }
            
            
            if ([cell accessoryType] == UITableViewCellAccessoryNone) {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            } else {
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            }
            
            self.collapsed[@(indexPath.section)] = @(![self.collapsed[@(indexPath.section)] boolValue]);
            
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];

        }

        if(indexPath.section == 3)
        {
            NSLog(@"clicked");

            
                        //if (index != NSNotFound) {
                UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
                //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
                if(indexPath.row == 0)
                {
                    NSLog(@"clicked 0");
                    if ([cell accessoryType] == UITableViewCellAccessoryNone) {
                            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                            //self.categoryAmerican = @"american";
                            self.categoryDict[@"American"] = @"american";
                        }
                         else {
                             [cell setAccessoryType:UITableViewCellAccessoryNone];
                             //self.categoryAmerican = nil;
                             [self.categoryDict removeObjectForKey:@"American"];
                        }

                }
            if(indexPath.row == 1)
            {
                NSLog(@"clicked 1");
                if ([cell accessoryType] == UITableViewCellAccessoryNone) {
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    
                    //self.categoryIndian = @"indian";
                    self.categoryDict[@"Indian"] = @"indian";
                    //[self.categoryDict setObject:@"indian"  forKey:@"Indian"];
                    
                    NSString *str = [self.categoryDict objectForKey:@"Indian"];
                    NSLog(@"%@", str);
                }
                else {
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    //self.categoryIndian = nil;
                    [self.categoryDict removeObjectForKey:@"Indian"];
                }
            }
            
            if(indexPath.row == 2)
            {
                NSLog(@"clicked 2");
                if ([cell accessoryType] == UITableViewCellAccessoryNone) {
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    //self.categoryThai = @"thai";
                    self.categoryDict[@"Thai"] = @"thai";
                }
                else {
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    //self.categoryThai = nil;
                    [self.categoryDict removeObjectForKey:@"Thai"];
                }

                
            }
            
        }

}
@end

//NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//[defaults setValue:@"My saved Data" forKey:@"infoString"];
