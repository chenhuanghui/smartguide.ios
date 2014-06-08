//
//  UserNotificationDetailCell.m
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationDetailCell.h"
#import "ImageManager.h"
#import "DataManager.h"

@interface UserNotificationDetailCell()<TokenViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation UserNotificationDetailCell

-(void)tokenViewTouchedToken:(TokenView *)token object:(id)obj
{
    [self.delegate userNotificationDetailCellTouchedAction:self action:obj];
}

-(void)loadWithUserNotificationDetail:(UserNotificationContent *)obj displayType:(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType
{
    _obj=obj;
    _displayType=displayType;
    
    lblTime.text=obj.time;
    lblTitle.attributedText=obj.titleAttribute;
    lblContent.attributedText=obj.contentAttribute;
    [tokens setTokens:obj.actionTitles objects:obj.actionsObjects];
    [imgvIcon loadShopLogoWithURL:obj.logo];
    
    float topHeight=0;
    float topY=30;
    
    if(displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL)
    {
        if(obj.video.length>0)
        {
            imgvVideoThumbnail.hidden=false;
            movideBGView.hidden=false;
            topHeight=obj.videoHeightForNoti.floatValue;
            
            [videoContain l_v_setH:topHeight];
            [imgvVideoThumbnail loadVideoThumbnailWithURL:obj.videoThumbnail];
        }
        else if(obj.image.length>0)
        {
            topHeight=obj.imageHeightForNoti.floatValue;
            
            [imgvImage loadUserNotificationContentWithURL:obj.image];
            [imgvImage l_v_setH:topHeight];
        }
        
        lblTitle.textColor=[UIColor blackColor];
        avatarMaskView.hidden=true;
    }
    else
    {
        if(obj.highlightUnread.boolValue)
        {
            avatarMaskView.hidden=false;
            lblTitle.textColor=[UIColor blackColor];
        }
        else
        {
            avatarMaskView.hidden=true;
            lblTitle.textColor=[UIColor grayColor];
        }
    }
    
//    displayView.backgroundColor=obj.highlightUnread.boolValue?[UIColor whiteColor]:COLOR255(205, 205, 205, 255);
    
    if(topHeight>0)
        topHeight+=5;
    
    [lblTitle l_v_setY:topY+topHeight];
    [lblTitle l_v_setH:obj.titleHeight.floatValue];
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+5];
    [lblContent l_v_setH:obj.contentHeight.floatValue];
    
    [tokens l_v_setY:lblContent.l_v_y+lblContent.l_v_h+5];
    [tokens l_v_setH:obj.actionsHeight.floatValue];
    
    lblContent.hidden=displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
    imgvImage.hidden=displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
    videoContain.hidden=displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
    
    btnLogo.userInteractionEnabled=obj.idShopLogo!=nil;
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(leftView.l_v_w+rightView.l_v_w, 0);
    
    //Chỉ user có tài khoản mới được phép remove notification
    scroll.scrollEnabled=currentUser().enumDataMode==USER_DATA_FULL;
}

-(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType
{
    return _displayType;
}

-(UserNotificationContent *)userNotificationDetail
{
    return _obj;
}

+(NSString *)reuseIdentifier
{
    return @"UserNotificationDetailCell";
}

+(float)heightWithUserNotificationDetail:(UserNotificationContent *)obj displayType:(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType
{
    float height=88;
    
    if(!obj.titleAttribute)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:[UIFont fontWithName:@"Avenir-Heavy" size:14] forKey:NSFontAttributeName];
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        
        NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
        paraStyle.alignment=NSTextAlignmentJustified;
        
        [dict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
        obj.titleAttribute=[[NSAttributedString alloc] initWithString:obj.title attributes:dict];
    }
    
    if(obj.titleHeight.floatValue==-1)
    {
        CGRect rect=[obj.titleAttribute boundingRectWithSize:CGSizeMake(274, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        obj.titleHeight=@(rect.size.height);
    }
    
    if(!obj.contentAttribute)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:[UIFont fontWithName:@"Avenir-Roman" size:13] forKey:NSFontAttributeName];
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        
        NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
        paraStyle.alignment=NSTextAlignmentJustified;
        [dict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
        
        obj.contentAttribute=[[NSAttributedString alloc] initWithString:obj.content attributes:dict];
    }
    
    if(obj.contentHeight.floatValue==-1)
    {
        obj.contentHeight=@([obj.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(274, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    }
    
    if(obj.actionsHeight.floatValue==-1)
    {
        obj.actionsHeight=@([TokenView heightWithTokens:obj.actionTitles forWidth:312]);
    }
    
    if(obj.imageHeightForNoti.floatValue==-1)
    {
        if(obj.image.length==0)
            obj.imageHeightForNoti=@(0);
        else
        {
            float imageWidth=274;
            obj.imageHeightForNoti=@(MAX(0, imageWidth*obj.imageHeight.floatValue/obj.imageWidth.floatValue));
        }
    }
    
    if(obj.videoHeightForNoti.floatValue==-1)
    {
        if(obj.video.length==0)
            obj.videoHeightForNoti=@(0);
        else
        {
            float videoWidth=274;
            obj.videoHeightForNoti=@(MAX(0, videoWidth*obj.videoHeight.floatValue/obj.videoWidth.floatValue));
        }
    }
    
    switch (displayType) {
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL:
            height+=obj.titleHeight.floatValue+obj.contentHeight.floatValue;
            height+=obj.actionsHeight.floatValue;
            
            if(obj.video.length>0)
                height+=obj.videoHeightForNoti.floatValue;
            else if(obj.image.length>0)
                height+=obj.imageHeightForNoti.floatValue;
            
            break;
            
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE:
            height+=obj.titleHeight.floatValue;
            height-=10;
            break;
    }
    
    return height;
}

- (IBAction)btnLogoTouchUpInside:(id)sender {
    [self.delegate userNotificationDetailCellTouchedLogo:self];
}

- (IBAction)btnRemoveTouchUpInsde:(id)sender
{
    [self.delegate userNotificationDetailCellTouchedRemove:self];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidEndDragged];
    });
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self scrollViewDidEndDragged];
}

-(void) scrollViewDidEndDragged
{
    [scroll killScroll];
    if(scroll.l_co_x>rightView.l_v_w/2)
        [scroll l_co_setX:rightView.l_v_w animate:true];
    else
        [scroll l_co_setX:0 animate:true];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate=self;
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    [leftView addGestureRecognizer:tap];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        return (int)scroll.l_co_x==0;
    }
    
    return true;
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    [self.delegate userNotificationDetailCellTouchedDetail:self];
}

- (IBAction)btnMovieTouchUpInside:(id)sender {
    if(_obj.video.length==0)
        return;
    
    imgvVideoThumbnail.hidden=true;
    movideBGView.hidden=true;
    
    MPMoviePlayerController *player=[self.delegate userNotificationDetailCellRequestPlayer:self];
    [player stop];
    [player.view removeFromSuperview];
    
    [videoContain addSubview:player.view];
    
    CGRect rect=videoContain.frame;
    rect.origin=CGPointZero;
    player.view.frame=rect;
    [player setContentURL:URL(_obj.video)];
    
    [player play];
}

@end

@implementation ScrollNotificationContent

-(void)setContentOffset:(CGPoint)contentOffset
{
    contentOffset.x=MAX(0,contentOffset.x);
    
    [super setContentOffset:contentOffset];
}

@end