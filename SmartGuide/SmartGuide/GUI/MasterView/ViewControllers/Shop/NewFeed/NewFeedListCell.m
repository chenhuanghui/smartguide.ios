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

-(void)loadWithHome3:(NSArray *)home3
{
    _dataMode=NEW_FEED_LIST_DATA_HOME3;
    _homes=[home3 mutableCopy];
    
    [table reloadData];
}

-(void)loadWithHome4:(NSArray *)home4
{
    _dataMode=NEW_FEED_LIST_DATA_HOME4;
    _homes=[home4 mutableCopy];
    
    [table reloadData];
}

-(void)loadWithHome5:(NSArray *)home5
{
    _dataMode=NEW_FEED_LIST_DATA_HOME5;
    _homes=[home5 mutableCopy];
    
    [table reloadData];
}

+(float)height
{
    return 155;
}

+(NSString *)reuseIdentifier
{
    return @"NewFeedListCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerNib:[UINib nibWithNibName:[NewFeedListObjectCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedListObjectCell reuseIdentifier]];
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
}

-(IBAction) btnNextTouchUpInside:(id)sender
{
    [self.delegate newFeedListTouched:self];
    return;
    NSIndexPath *indexPath=[table indexPathForRowAtPoint:CGPointMake(self.l_v_h/2, table.l_co_y+self.l_v_w/2)];
    
    if(indexPath)
    {
        if(indexPath.row+1<[table numberOfRowsInSection:indexPath.section])
        {
            indexPath=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:true];
        }
    }
}

-(id)currentHome
{
    NSIndexPath *indexPath=[table indexPathForRowAtPoint:CGPointMake(self.l_v_h/2, table.l_co_y+self.l_v_w/2)];
    
    if(indexPath)
    {
        return _homes[indexPath.row];
    }
    
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _homes.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _homes.count;
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
