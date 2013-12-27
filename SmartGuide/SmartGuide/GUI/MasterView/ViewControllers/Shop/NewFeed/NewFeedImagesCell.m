//
//  NewFeedImagesCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedImagesCell.h"
#import "Utility.h"
#import "NewFeedImageCell.h"
#import "Constant.h"

@implementation NewFeedImagesCell

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
    return @"NewFeedImagesCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
 
    [table registerNib:[UINib nibWithNibName:[NewFeedImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedImageCell reuseIdentifier]];
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
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
    NewFeedImageCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedImageCell reuseIdentifier]];
    
    [cell loadImage:_images[indexPath.row]];
    
    return cell;
}

@end
