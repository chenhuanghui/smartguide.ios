//
//  NewFeedListCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomeListCell.h"
#import "HomeListObjectCell.h"
#import "HomeListImageCell.h"
#import "Placelist.h"
#import "Utility.h"
#import "UserHome.h"

@implementation HomeListCell
@synthesize delegate;

-(void) config
{
    switch (_displayMode) {
        case NEW_FEED_LIST_DISPLAY_USED:
        {
            [tableSlide reloadData];
            tableSlide.hidden=false;
            pageControl.hidden=false;
        }
            break;
            
        case NEW_FEED_LIST_DISPLAY_SLIDE:
        {
            [tableSlide reloadData];
            tableSlide.hidden=false;
            pageControl.hidden=false;
        }
            break;
    }
}

-(void)loadWithHome3:(UserHome *)home
{
    _home=home;
    
    _dataMode=NEW_FEED_LIST_DATA_HOME3;
    _homes=home.home3Objects;
    _displayMode=home.imagesObjects.count==0?NEW_FEED_LIST_DISPLAY_USED:NEW_FEED_LIST_DISPLAY_SLIDE;
    _images=home.imagesObjects;
    pageControl.numberOfPages=_images.count;
    
    [self config];
    
    [tablePlace reloadData];
}

-(void)loadWithHome4:(UserHome *)home
{
    _home=home;
    
    _dataMode=NEW_FEED_LIST_DATA_HOME4;
    _homes=home.home4Objects;
    _displayMode=home.imagesObjects.count==0?NEW_FEED_LIST_DISPLAY_USED:NEW_FEED_LIST_DISPLAY_SLIDE;
    _images=home.imagesObjects;
    pageControl.numberOfPages=_images.count;
    
    [self config];
    
    [tablePlace reloadData];
}

-(void)loadWithHome5:(UserHome *)home
{
    _home=home;
    
    _dataMode=NEW_FEED_LIST_DATA_HOME5;
    _homes=home.home5Objects;
    _displayMode=home.imagesObjects.count==0?NEW_FEED_LIST_DISPLAY_USED:NEW_FEED_LIST_DISPLAY_SLIDE;
    _images=home.imagesObjects;
    pageControl.numberOfPages=_images.count;
    
    [self config];
    
    [tablePlace reloadData];
}

+(float)heightWithHome:(UserHome *)home
{
    if(home.imagesObjects.count==0)
        return 170;
    
    return 345;
}

+(NSString *)reuseIdentifier
{
    return @"HomeListCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [tablePlace registerNib:[UINib nibWithNibName:[HomeListObjectCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeListObjectCell reuseIdentifier]];
    [tableSlide registerNib:[UINib nibWithNibName:[HomeListImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeListImageCell reuseIdentifier]];
    
    CGRect rect=tablePlace.frame;
    tablePlace.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tablePlace.frame=rect;
    
    rect=tableSlide.frame;
    tableSlide.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tableSlide.frame=rect;
    
    pageControl.dotColorCurrentPage=[UIColor whiteColor];
    pageControl.dotColorOtherPage=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate homeListTouched:self];
}

-(IBAction) btnNextTouchUpInside:(id)sender
{
    NSIndexPath *indexPath=[tablePlace indexPathForRowAtPoint:CGPointMake(tablePlace.l_v_w/2, tablePlace.l_co_y+self.l_v_w/2)];
    
    if(indexPath)
    {
        if(indexPath.row+1<[tablePlace numberOfRowsInSection:indexPath.section])
        {
            indexPath=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            [tablePlace scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:true];
        }
    }
}

- (IBAction)btnPreviousTouchUpInside:(id)sender {
    NSIndexPath *indexPath=[tablePlace indexPathForRowAtPoint:CGPointMake(tablePlace.l_v_w/2, tablePlace.l_co_y+self.l_v_w/2)];
    
    if(indexPath)
    {
        if(indexPath.row-1<[tablePlace numberOfRowsInSection:indexPath.section])
        {
            indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
            [tablePlace scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:true];
        }
    }
}

-(id)currentHome
{
    NSIndexPath *indexPath=[tablePlace indexPathForRowAtPoint:CGPointMake(tablePlace.l_v_h/2, tablePlace.l_co_y+tablePlace.l_v_w/2)];
    
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
        HomeListObjectCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeListObjectCell reuseIdentifier]];
        
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
    else if(tableView==tableSlide)
    {
        HomeListImageCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeListImageCell reuseIdentifier]];
        UserHomeImage *img=_images[indexPath.row];
        
        [cell loadImageWithURL:img.image];
        
        return cell;
    }
    
    return [UITableViewCell new];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==tableSlide)
    {
        [pageControl scrollViewDidScroll:scrollView isHorizontal:true];
    }
}

@end
