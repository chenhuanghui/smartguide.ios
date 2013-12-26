//
//  NewFeedListCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedListCell.h"
#import "NewFeedListObjectCell.h"
#import "Utility.h"

@implementation NewFeedListCell
@synthesize delegate;

-(void) config
{
    switch (_displayMode) {
        case NEW_FEED_LIST_DISPLAY_USED:
            if(tableTutorial)
                [tableTutorial removeFromSuperview];
            break;
            
        default:
            break;
    }
}

-(void)loadWithHome3:(NSArray *)home3 displayMode:(enum NEW_FEED_LIST_DISPLAY_MODE)displayMode
{
    _dataMode=NEW_FEED_LIST_DATA_HOME3;
    _homes=[home3 mutableCopy];
    _displayMode=displayMode;
    
    [tablePlace reloadData];
}

-(void)loadWithHome4:(NSArray *)home4 displayMode:(enum NEW_FEED_LIST_DISPLAY_MODE)displayMode
{
    _dataMode=NEW_FEED_LIST_DATA_HOME4;
    _homes=[home4 mutableCopy];
    _displayMode=displayMode;
    
    [tablePlace reloadData];
}

-(void)loadWithHome5:(NSArray *)home5 displayMode:(enum NEW_FEED_LIST_DISPLAY_MODE)displayMode
{
    _dataMode=NEW_FEED_LIST_DATA_HOME5;
    _homes=[home5 mutableCopy];
    _displayMode=displayMode;
    
    [tablePlace reloadData];
}

+(float)heightWithMode:(enum NEW_FEED_LIST_DISPLAY_MODE)displayMode
{
    switch (displayMode) {
        case NEW_FEED_LIST_DISPLAY_TUTORIAL:
            return 345;
            
        case NEW_FEED_LIST_DISPLAY_USED:
            return 173;
    }
}

+(NSString *)reuseIdentifier
{
    return @"NewFeedListCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [tablePlace registerNib:[UINib nibWithNibName:[NewFeedListObjectCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedListObjectCell reuseIdentifier]];
    
    CGRect rect=tablePlace.frame;
    tablePlace.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tablePlace.frame=rect;
    
    rect=tableTutorial.frame;
    tableTutorial.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tableTutorial.frame=rect;
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
    else if(tableView==tableTutorial)
        return _tutorials.count==0?0:1;
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tablePlace)
        return _homes.count;
    else if(tableView==tableTutorial)
        return _tutorials.count;
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewFeedListObjectCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListObjectCell reuseIdentifier]];
    
    switch (_dataMode) {
        case NEW_FEED_LIST_DATA_HOME3:
        {
            UserHome3 *home=_homes[indexPath.row];
            [cell setImage:home.cover title:home.title numOfShop:home.numOfShop content:home.content];
            
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

@end
