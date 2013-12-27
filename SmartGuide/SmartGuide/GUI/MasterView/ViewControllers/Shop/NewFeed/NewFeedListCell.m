//
//  NewFeedListCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedListCell.h"
#import "NewFeedListObjectCell.h"
#import "NewFeedListImageCell.h"
#import "Placelist.h"
#import "Utility.h"
#import "UserHome.h"

@implementation NewFeedListCell
@synthesize delegate;

-(void) config
{
    switch (_displayMode) {
        case NEW_FEED_LIST_DISPLAY_USED:
        {
            [tableSlide reloadData];
            tableSlide.hidden=true;
        }
            break;
            
        case NEW_FEED_LIST_DISPLAY_SLIDE:
        {
            [tableSlide reloadData];
            tableSlide.hidden=false;
        }
            break;
    }
}

-(void)loadWithHome3:(UserHome *)home
{
    _dataMode=NEW_FEED_LIST_DATA_HOME3;
    _homes=[home.home3Objects mutableCopy];
    _displayMode=home.imagesObjects.count==0?NEW_FEED_LIST_DISPLAY_USED:NEW_FEED_LIST_DISPLAY_SLIDE;
    _images=[home.imagesObjects mutableCopy];
    
    [self config];
    
    [tablePlace reloadData];
}

-(void)loadWithHome4:(UserHome *)home
{
    _dataMode=NEW_FEED_LIST_DATA_HOME4;
    _homes=[home.home4Objects mutableCopy];
    _displayMode=home.imagesObjects.count==0?NEW_FEED_LIST_DISPLAY_USED:NEW_FEED_LIST_DISPLAY_SLIDE;
    _images=[home.imagesObjects mutableCopy];
    
    [self config];
    
    [tablePlace reloadData];
}

-(void)loadWithHome5:(UserHome *)home
{
    _dataMode=NEW_FEED_LIST_DATA_HOME5;
    _homes=[home.home5Objects mutableCopy];
    _displayMode=home.imagesObjects.count==0?NEW_FEED_LIST_DISPLAY_USED:NEW_FEED_LIST_DISPLAY_SLIDE;
    _images=[home.imagesObjects mutableCopy];
    
    [self config];
    
    [tablePlace reloadData];
}

+(float)heightWithHome:(UserHome *)home
{
    if(home.imagesObjects.count==0)
        return 173;
    
    return 345;
}

+(NSString *)reuseIdentifier
{
    return @"NewFeedListCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [tablePlace registerNib:[UINib nibWithNibName:[NewFeedListObjectCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedListObjectCell reuseIdentifier]];
    [tableSlide registerNib:[UINib nibWithNibName:[NewFeedListImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedListImageCell reuseIdentifier]];
    
    CGRect rect=tablePlace.frame;
    tablePlace.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tablePlace.frame=rect;
    
    rect=tableSlide.frame;
    tableSlide.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tableSlide.frame=rect;
}

-(IBAction) btnNextTouchUpInside:(id)sender
{
    [self.delegate newFeedListTouched:self];
    return;
    NSIndexPath *indexPath=[tablePlace indexPathForRowAtPoint:CGPointMake(self.l_v_h/2, tablePlace.l_co_y+self.l_v_w/2)];
    
    if(indexPath)
    {
        if(indexPath.row+1<[tablePlace numberOfRowsInSection:indexPath.section])
        {
            indexPath=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            [tablePlace scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:true];
        }
    }
}

-(id)currentHome
{
    NSIndexPath *indexPath=[tablePlace indexPathForRowAtPoint:CGPointMake(self.l_v_h/2, tablePlace.l_co_y+self.l_v_w/2)];
    
    if(indexPath)
    {
        return _homes[indexPath.row];
    }
    
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==tablePlace)
        return _homes.count==0?0:1;
    else if(tableView==tableSlide)
        return _images.count==0?0:1;
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tablePlace)
        return _homes.count;
    else if(tableView==tableSlide)
        return _images.count;
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tablePlace)
    {
        NewFeedListObjectCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListObjectCell reuseIdentifier]];
        
        switch (_dataMode) {
            case NEW_FEED_LIST_DATA_HOME3:
            {
                UserHome3 *home=_homes[indexPath.row];
                [cell setImage:home.cover title:home.place.title numOfShop:home.numOfShop content:home.content];
                
                return cell;
            }
                
            case NEW_FEED_LIST_DATA_HOME4:
            {
                UserHome4 *home=_homes[indexPath.row];
                [cell setImage:home.cover title:home.shopName numOfShop:home.numOfView content:home.content];
                
                return cell;
            }
                
            case NEW_FEED_LIST_DATA_HOME5:
            {
                UserHome5 *home=_homes[indexPath.row];
                [cell setImage:home.cover title:home.storeName numOfShop:home.numOfPurchase content:home.content];
                
                return cell;
            }
        }
    }
    else if(tableView==tableSlide)
    {
        NewFeedListImageCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListImageCell reuseIdentifier]];
        UserHomeImage *img=_images[indexPath.row];
        
        [cell loadImageWithURL:img.image];
        
        return cell;
    }
    
    return [UITableViewCell new];
}

@end
