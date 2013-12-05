//
//  SUKM1Cell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUKM1Cell.h"
#import "Utility.h"

@implementation SUKM1Cell

-(void)loadWithKM:(NSArray *)array
{
    data=[array copy];
    
    table.dataSource=self;
    table.delegate=self;
    [table reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return data.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopKM1Cell heightWithContent:data[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopKM1Cell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopKM1Cell reuseIdentifier]];
    
    NSArray *array=@[@"A",@"B",@"C",@"D"];
    
    [cell setVoucher:array[random_int(0, array.count)] content:data[indexPath.row] sgp:@"99" isHighlighted:random()%2==0];
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"SUKM1Cell";
}

+(float)heightWithKM:(NSArray *)array
{
    float height=208;
    for(NSString *str in array)
    {
        height+=[ShopKM1Cell heightWithContent:str];
    }
    
    return height;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerNib:[UINib nibWithNibName:[ShopKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM1Cell reuseIdentifier]];
}



@end
