//
//  SUKMNewsContaintCell.m
//  Infory
//
//  Created by XXX on 6/6/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopKMNewsControllerCell.h"
#import "ShopKMNewsCell.h"
#import "AppDelegate.h"

@interface ShopKMNewsControllerCell()<UITableViewDataSource,UITableViewDelegate,ShopKMNewsCellDelegate>
{
}

@end

@implementation ShopKMNewsControllerCell

+(float)heightWithKMNews:(NSArray *)kms
{
    float height=0;
    
    for(PromotionNews *km in kms)
        height+=[ShopKMNewsCell heightWithPromotionNews:km];
    
    return height;
}

-(void)loadWithKMNews:(NSArray *)kms maxHeight:(float)maxHeight
{
    [tableKM l_v_setH:maxHeight];
    
    _kmNews=kms;
    [tableKM reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _kmNews.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _kmNews.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopKMNewsCell heightWithPromotionNews:_kmNews[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopKMNewsCell *cell=[tableView shopKMNewsCell];
    [cell loadWithPromotionNews:_kmNews[indexPath.row]];
    cell.delegate=self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromotionNews *km=_kmNews[indexPath.row];
    if(_player && _player.contentURL && km.video.length>0 && [_player.contentURL.absoluteString isEqualToString:km.video])
    {
        [_player stop];
        [_player.view removeFromSuperview];
    }
}

-(MPMoviePlayerController *)shopKMNewsCellRequestPlayer:(ShopKMNewsCell *)cell
{
    if(!_player)
    {
        _player=[MPMoviePlayerController new];
        _player.shouldAutoplay=false;
    }
    
    return _player;
}

-(void)dealloc
{
    if(_player)
    {
        [_player stop];
        [_player.view removeFromSuperview];
        _player=nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)tableDidScroll:(UITableView *)table
{
    NSIndexPath *idx=[table indexPathForCell:self];
    CGRect rect=[table rectForRowAtIndexPath:idx];
    
    if(table.l_co_y+100-rect.origin.y>0)
    {
        [tableKM l_v_setY:table.l_co_y+100-rect.origin.y];
        [tableKM l_co_setY:table.l_co_y+100-rect.origin.y];
    }
    else
    {
        [tableKM l_v_setY:0];
        [tableKM l_co_setY:0];
    }
}

-(void)tableDidEndDisplayCell:(UICollectionView *)table
{
    if(_player.view.superview)
    {
        [_player stop];
        [_player.view removeFromSuperview];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [tableKM registerShopKMNewsCell];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieNotification:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieNotification:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
}

-(void) movieNotification:(NSNotification*) notification
{
    if([notification.name isEqualToString:MPMoviePlayerWillEnterFullscreenNotification])
    {
        AppDelegate *app=[UIApplication sharedApplication].delegate;
        
        app.allowRotation=true;
    }
    else if([notification.name isEqualToString:MPMoviePlayerWillExitFullscreenNotification])
    {
        AppDelegate *app=[UIApplication sharedApplication].delegate;
        
        app.allowRotation=false;
    }
}

+(NSString *)reuseIdentifier
{
    return @"ShopKMNewsControllerCell";
}

@end

@implementation UITableView(ShopKMNewsControllerCell)

-(void)registerShopKMNewsControllerCell
{
    [self registerNib:[UINib nibWithNibName:[ShopKMNewsControllerCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKMNewsControllerCell reuseIdentifier]];
}

-(ShopKMNewsControllerCell *)shopKMNewsControllerCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopKMNewsControllerCell reuseIdentifier]];
}

@end