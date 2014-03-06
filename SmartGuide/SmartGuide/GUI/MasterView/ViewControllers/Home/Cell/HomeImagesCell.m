//
//  NewFeedImagesCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomeImagesCell.h"
#import "Utility.h"
#import "HomeImageCell.h"
#import "Constant.h"

@implementation HomeImagesCell

-(void)loadWithImages:(NSArray *) images
{
    _images=[images mutableCopy];
    
    [table reloadData];
}

+(float)height
{
    return 290+NEW_FEED_CELL_SPACING;
}

+(NSString *)reuseIdentifier
{
    return @"HomeImagesCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
 
    [table registerNib:[UINib nibWithNibName:[HomeImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeImageCell reuseIdentifier]];
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
    
    table.layer.cornerRadius=2;
    table.layer.masksToBounds=true;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _images.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _images.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return table.l_v_w;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeImageCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeImageCell reuseIdentifier]];
    
    cell.table=tableView;
    cell.indexPath=indexPath;
    [cell loadImage:_images[indexPath.row]];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for(HomeImageCell *cell in table.visibleCells)
    {
        if([cell isKindOfClass:[HomeImageCell class]])
            [cell tableDidScroll];
    }
}

@end
