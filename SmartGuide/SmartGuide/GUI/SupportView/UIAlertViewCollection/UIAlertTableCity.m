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

@interface UIAlertTableCity()
{
    UIView *view;
}

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation UIAlertTableCity
@synthesize selectedCity,tap;

-(void)show
{
    [super show];
    
    self.tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor color255WithRed:1 green:1 blue:1 alpha:1.f];
    view.alpha=0.1f;
    
    [self.superview insertSubview:view belowSubview:self];
    
    [view addGestureRecognizer:self.tap];
}

-(void)tap:(UITapGestureRecognizer*) tapGes
{
    //    tapGes.enabled=false;
    //    [view removeGestureRecognizer:self.tap];
    //    self.tap=nil;
    //
    CGPoint pnt=[tapGes locationInView:tapGes.view];
    
    if(!CGRectContainsPoint(self.frame, pnt))
        [self dismissWithClickedButtonIndex:0 animated:true];
}

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
