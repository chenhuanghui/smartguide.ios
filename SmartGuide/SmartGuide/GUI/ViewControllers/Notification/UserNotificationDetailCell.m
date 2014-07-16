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
#import "UserNotificationDetailButtonTableViewCell.h"

@interface UserNotificationDetailCell()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UserNotificationDetailButtonTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserNotificationDetailCell

-(void)loadWithUserNotificationDetail:(UserNotificationContent *)obj displayType:(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType cellHeight:(float)cellHeight
{
    _obj=obj;
    _displayType=displayType;
    _actions=obj.actionsObjects;
    
    lblTime.text=obj.time;
    lblTitle.attributedText=obj.titleAttribute;
    lblContent.attributedText=obj.contentAttribute;
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
        lblTime.textColor=[UIColor blackColor];
        
        markUnreadView.hidden=true;
    }
    else
    {
        if(obj.highlightUnread.boolValue)
        {
            avatarMaskView.hidden=false;
            lblTitle.textColor=[UIColor blackColor];
            lblTime.textColor=[UIColor blackColor];
            markUnreadView.hidden=false;
        }
        else
        {
            avatarMaskView.hidden=true;
            lblTitle.textColor=[UIColor grayColor];
            lblTime.textColor=[UIColor grayColor];
            markUnreadView.hidden=true;
        }
    }
    
    if(displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL)
        displayView.backgroundColor=[UIColor whiteColor];
    else
        displayView.backgroundColor=obj.highlightUnread.boolValue?[UIColor whiteColor]:COLOR255(205, 205, 205, 255);
    
    if(topHeight>0)
        topHeight+=5;
    
    if(displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE)
        topY-=5;
    
    [lblTitle l_v_setY:topY+topHeight];
    [lblTitle l_v_setH:obj.titleHeight.floatValue];
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+5];
    [lblContent l_v_setH:obj.contentHeight.floatValue];
    
    [tableButtons l_v_setY:lblContent.l_v_y+lblContent.l_v_h+5];
    [tableButtons l_v_setH:obj.actionsHeight.floatValue];
    tableButtons.hidden=displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
    
    lblContent.hidden=displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
    imgvImage.hidden=displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
    videoContain.hidden=displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
    
    btnLogo.userInteractionEnabled=obj.idShopLogo!=nil;
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(leftView.l_v_w+rightView.l_v_w, 0);
    
    //Chỉ user có tài khoản mới được phép remove notification
    scroll.scrollEnabled=currentUser().enumDataMode==USER_DATA_FULL;
    [tableButtons reloadData];
}

-(void)userNotificationDetailButtonTableViewCellTouchedAction:(UserNotificationDetailButtonTableViewCell *)cell
{
    [self.delegate userNotificationDetailCellTouchedAction:self action:cell.action];
}

-(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType
{
    return _displayType;
}

-(UserNotificationContent *)userNotificationDetail
{
    return _obj;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _actions.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _actions.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UserNotificationDetailButtonTableViewCell heightWithAction:_actions[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserNotificationDetailButtonTableViewCell *cell=[tableButtons userNotificationDetailButtonTableViewCell];
    enum CELL_POSITION cellPos=CELL_POSITION_TOP;
    
    if(indexPath.row==_actions.count-1)
        cellPos=CELL_POSITION_BOTTOM;
    else if(indexPath.row==0)
        cellPos=CELL_POSITION_TOP;
    else
        cellPos=CELL_POSITION_MIDDLE;
    
    [cell loadWithAction:_actions[indexPath.row] cellPos:cellPos];
    cell.delegate=self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserNotificationDetailButtonTableViewCell *cell=(UserNotificationDetailButtonTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    [self.delegate userNotificationDetailCellTouchedAction:self action:cell.action];
}

+(NSString *)reuseIdentifier
{
    return @"UserNotificationDetailCell";
}

+(float)heightWithUserNotificationDetail:(UserNotificationContent *)obj displayType:(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType
{
    float height=53;
    
    if(!obj.titleAttribute)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:FONT_SIZE_BOLD(14) forKey:NSFontAttributeName];
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
        [dict setObject:FONT_SIZE_NORMAL(13) forKey:NSFontAttributeName];
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        
        NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
        paraStyle.alignment=NSTextAlignmentJustified;
        [dict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
        
        obj.contentAttribute=[[NSAttributedString alloc] initWithString:obj.content attributes:dict];
    }
    
    if(obj.contentHeight.floatValue==-1)
    {
        obj.contentHeight=@([obj.content sizeWithFont:FONT_SIZE_NORMAL(13) constrainedToSize:CGSizeMake(274, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    }
    
    if(obj.actionsHeight.floatValue==-1)
    {
        float actionsHeight=0;
        
        for(UserNotificationAction *action in obj.actionsObjects)
            actionsHeight+=[UserNotificationDetailButtonTableViewCell heightWithAction:action];
        
        obj.actionsHeight=@(actionsHeight);
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
            
            if(obj.video.length>0 && obj.videoHeightForNoti.floatValue>0)
                height+=obj.videoHeightForNoti.floatValue+5;
            else if(obj.image.length>0 && obj.imageHeightForNoti.floatValue>0)
                height+=obj.imageHeightForNoti.floatValue+5;
            
            height+=obj.titleHeight.floatValue+5;
            height+=obj.contentHeight.floatValue+5;
            
            if(obj.actionsHeight.floatValue>0)
                height+=obj.actionsHeight.floatValue;
            
            break;
            
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE:
            height+=obj.titleHeight.floatValue;
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
    
    [tableButtons registerUserNotificationDetailButtonTableViewCell];
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