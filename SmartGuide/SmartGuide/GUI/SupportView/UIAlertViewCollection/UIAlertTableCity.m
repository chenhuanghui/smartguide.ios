//
//  UIAlertTableCity.m
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UIAlertTableCity.h"
#import "Utility.h"
#import "City.h"

@implementation UIAlertTableCity
@synthesize selectedCity;

-(void)prepare
{
    [super prepare];
    
    _citys=[[City allObjects] mutableCopy];
    
    self.tableAlertView.dataSource=self;
    self.tableAlertView.delegate=self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _citys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    City *city=[_citys objectAtIndex:indexPath.row];
    
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text=city.name;
    
    if(city.idCity.integerValue==selectedCity.idCity.integerValue)
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType=UITableViewCellAccessoryNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedCity=[_citys objectAtIndex:indexPath.row];
    
    [self.tableAlertView reloadData];
    
    [self dismissWithClickedButtonIndex:0 animated:true];
    _onOK();
}

@end
