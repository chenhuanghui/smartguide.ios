//
//  SUKMNewsCell.m
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopKMNewsCell.h"
#import "ImageManager.h"
#import "Utility.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation ShopKMNewsCell

-(void)loadWithPromotionNews:(PromotionNews *)news
{
    _km=news;
    
    lblTitle.text=news.title;
    lblContent.text=news.content;
    lblDuration.text=news.duration;
    
    float topHeight=0;
    
    if(news.video.length>0)
    {
        topHeight=news.videoHeightForShop.floatValue;
        cover.hidden=true;
        videoContain.hidden=false;
        imgvMovieThumbnail.hidden=false;
        movieBGView.hidden=false;
        [imgvMovieThumbnail loadVideoThumbnailWithURL:news.videoThumbnail];
        [videoContain l_v_setH:news.videoHeightForShop.floatValue];
    }
    else
    {
        topHeight=news.imageHeightForShop.floatValue;
        
        videoContain.hidden=true;
        cover.hidden=false;
        
        [cover loadImagePromotionNewsWithURL:news.image size:CGSizeMake(cover.l_v_w, news.imageHeightForShop.floatValue)];
        [cover l_v_setH:news.imageHeightForShop.floatValue];
    }
    
    [lblTitle l_v_setY:20+topHeight];
    [lblTitle l_v_setH:news.titleHeight.floatValue];
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+20];
    [lblContent l_v_setH:news.contentHeight.floatValue];
}

-(void)hideLine
{
    lineStatus.hidden=true;
}

+(NSString *)reuseIdentifier
{
    return @"ShopKMNewsCell";
}

+(float)heightWithPromotionNews:(PromotionNews *)news
{
    if(news.kmHeight.floatValue!=-1)
        return news.kmHeight.floatValue;
    
    float height=90;
    
    if(news.titleHeight.floatValue==-1)
        news.titleHeight=@([news.title sizeWithFont:FONT_SIZE_BOLD(14) constrainedToSize:CGSizeMake(264, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=news.titleHeight.floatValue;
    
    if(news.contentHeight.floatValue==-1)
        news.contentHeight=@([news.content sizeWithFont:FONT_SIZE_NORMAL(13) constrainedToSize:CGSizeMake(264, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=news.contentHeight.floatValue;
    
    if(news.videoHeightForShop.floatValue==-1)
    {
        if(news.video.length==0)
            news.videoHeightForShop=@(0);
        else
        {
            float frameWidthLayoutNews=304;
            news.videoHeightForShop=@(frameWidthLayoutNews*news.videoHeight.floatValue/news.videoWidth.floatValue);
        }
    }
    
    if(news.imageHeightForShop.floatValue==-1)
    {
        if(news.image.length==0)
            news.imageHeightForShop=@(0);
        else
        {
            float frameWidthLayoutNews=304;
            news.imageHeightForShop=@(frameWidthLayoutNews*news.imageHeight.floatValue/news.imageWidth.floatValue);
        }
    }
    
    if(news.video.length>0)
        height+=news.videoHeightForShop.floatValue;
    else
        height+=news.imageHeightForShop.floatValue;
    
    news.kmHeight=@(height);
    
    return height;
}

- (IBAction)btnMovieTouchUpInside:(id)sender {
    if(_km.video.length==0)
        return;
    
    imgvMovieThumbnail.hidden=true;
    movieBGView.hidden=true;
    
    MPMoviePlayerController *player=[self.delegate shopKMNewsCellRequestPlayer:self];
    [player stop];
    [player.view removeFromSuperview];
    
    [videoContain addSubview:player.view];
    
    CGRect rect=videoContain.frame;
    rect.origin=CGPointZero;
    player.view.frame=rect;
    [player setContentURL:URL(_km.video)];
    
    [player play];
}

@end

@implementation UITableView(SUKMNewsCell)

-(void)registerShopKMNewsCell
{
    [self registerNib:[UINib nibWithNibName:[ShopKMNewsCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKMNewsCell reuseIdentifier]];
}

-(ShopKMNewsCell *)shopKMNewsCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopKMNewsCell reuseIdentifier]];
}

@end