//
//  HomeImagesType9Cell.m
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeImagesType9Cell.h"
#import "Utility.h"
#import "HomeImageType9Cell.h"

@implementation HomeImagesType9Cell

-(void)loadWithHome9:(UserHome *)home
{
    _home=home;
    page.numberOfPages=_home.imagesObjects.count;
    page.hidden=_home.imagesObjects.count==1;
    
    [table reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [page scrollViewDidScroll:scrollView isHorizontal:true];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _home.imagesObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _home.imagesObjects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeImageType9Cell *cell=(HomeImageType9Cell*)[tableView dequeueReusableCellWithIdentifier:[HomeImageType9Cell reuseIdentifier]];
    UserHomeImage *img=_home.imagesObjects[0];
    
    cell.table=tableView;
    cell.indexPath=indexPath;
    cell.home=_home;
    
    [cell loadWithURL:img.image width:_home.imageWidth.floatValue height:_home.imageHeight.floatValue];
    
    return cell;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
 
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
    
    [table registerNib:[UINib nibWithNibName:[HomeImageType9Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeImageType9Cell reuseIdentifier]];
    
    page.dotColorCurrentPage=[UIColor whiteColor];
    page.dotColorOtherPage=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
}

+(NSString *)reuseIdentifier
{
    return @"HomeImagesType9Cell";
}

@end
