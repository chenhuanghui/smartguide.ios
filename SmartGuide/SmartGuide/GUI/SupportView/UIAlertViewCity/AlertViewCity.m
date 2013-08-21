//
//  AlertViewCity.m
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "AlertViewCity.h"
#import "City.h"
#import "Utility.h"

@implementation AlertViewCity
@synthesize selectedCity;

-(AlertViewCity *)initAlertViewCityWithCity:(NSArray *)cities
{
    self=[super initWithTitle:nil message:@"Select your city" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    _cities=[[NSArray alloc] initWithArray:cities];
    
    [self prepare];
    
    return self;
}

-(void)prepare
{
    [super prepare];
    
    self.tableAlertView.dataSource=self;
    self.tableAlertView.delegate=self;
}

-(void)show
{
    [super show];
    
    [self setEnableOKButton:false];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    City *city=[_cities objectAtIndex:indexPath.row];
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.detailTextLabel.text=city.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setEnableOKButton:true];
    
    selectedCity=[_cities objectAtIndex:indexPath.row];
}

@end