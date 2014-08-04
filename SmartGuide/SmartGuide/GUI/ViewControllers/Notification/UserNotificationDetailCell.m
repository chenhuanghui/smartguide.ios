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
#import "UserNotificationContent.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UserNotificationDetailViewController.h"

@interface UserNotificationDetailCell()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UserNotificationDetailButtonTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserNotificationDetailCell
@synthesize suggestHeight, isCalculatingSuggestHeight;

-(void)loadWithUserNotificationDetail:(UserNotificationContent *)obj
{
    _obj=obj;
    isCalculatingSuggestHeight=false;
    [self setNeedsLayout];
}

-(void) calculatorHeights
{
    if(!_obj.titleAttribute)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:FONT_SIZE_BOLD(14) forKey:NSFontAttributeName];
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        
        NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
        paraStyle.alignment=NSTextAlignmentJustified;
        
        [dict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
        _obj.titleAttribute=[[NSAttributedString alloc] initWithString:_obj.title attributes:dict];
    }
    
    if(!_obj.contentAttribute)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:FONT_SIZE_NORMAL(13) forKey:NSFontAttributeName];
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        
        NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
        paraStyle.alignment=NSTextAlignmentJustified;
        [dict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
        
        _obj.contentAttribute=[[NSAttributedString alloc] initWithString:_obj.content attributes:dict];
    }
    
    if(_obj.actionsHeight.floatValue==-1)
    {
        float actionsHeight=0;
        
        for(UserNotificationAction *action in _obj.actionsObjects)
            actionsHeight+=[UserNotificationDetailButtonTableViewCell heightWithAction:action];
        
        _obj.actionsHeight=@(actionsHeight);
    }
    
    if(_obj.imageHeightForNoti.floatValue==-1)
    {
        if(_obj.image.length==0)
            _obj.imageHeightForNoti=@(0);
        else
        {
            float imageWidth=274;
            _obj.imageHeightForNoti=@(MAX(0, imageWidth*_obj.imageHeight.floatValue/_obj.imageWidth.floatValue));
        }
    }
    
    if(_obj.videoHeightForNoti.floatValue==-1)
    {
        if(_obj.video.length==0)
            _obj.videoHeightForNoti=@(0);
        else
        {
            float videoWidth=274;
            _obj.videoHeightForNoti=@(MAX(0, videoWidth*_obj.videoHeight.floatValue/_obj.videoWidth.floatValue));
        }
    }
}

-(void)calculatingSuggestHeight
{
    isCalculatingSuggestHeight=true;
    [self layoutSubviews];
    isCalculatingSuggestHeight=false;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self calculatorHeights];
    
    btnLogo.userInteractionEnabled=_obj.idShopLogo!=nil;
    if(!isCalculatingSuggestHeight)
        [imgvIcon loadShopLogoWithURL:_obj.logo];
    
    [UIView setAnimationsEnabled:false];
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(leftView.l_v_w+rightView.l_v_w, 0);
    
    //Chỉ user có tài khoản mới được phép remove notification
    scroll.scrollEnabled=currentUser().enumDataMode==USER_DATA_FULL;
    
    switch (_obj.enumDisplayType) {
            
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE:
            lblTime.frame=CGRectMake(55, 6, 257, 0);
            lblTime.text=_obj.time;
            
            [lblTime sizeToFit];
            
            lblTitle.frame=CGRectMake(19, lblTime.l_v_y+lblTime.l_v_h+5, 274, 0);
            lblTitle.attributedText=_obj.titleAttribute;
            
            [lblTitle sizeToFit];
            
            imgvImage.hidden=true;
            videoContain.hidden=true;
            lblContent.hidden=true;
            tableButtons.dataSource=nil;
            tableButtons.delegate=nil;
            tableButtons.hidden=true;
            
            if(_obj.enumStatus==NOTIFICATION_STATUS_UNREAD && _obj.highlightUnread.boolValue)
            {
                markUnreadView.hidden=false;
                avatarMaskView.hidden=false;
                displayView.backgroundColor=[UIColor whiteColor];
                lblTime.textColor=[UIColor blackColor];
                lblTitle.textColor=[UIColor blackColor];
            }
            else
            {
                markUnreadView.hidden=true;
                avatarMaskView.hidden=true;
                displayView.backgroundColor=COLOR255(205, 205, 205, 255);
                lblTitle.textColor=[UIColor grayColor];
                lblTime.textColor=[UIColor grayColor];
            }
            
            suggestHeight=lblTitle.l_v_y+lblTitle.l_v_h+10;
            
            break;
            
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL:
            
            displayView.backgroundColor=[UIColor whiteColor];
            
            lblTime.frame=CGRectMake(55, 6, 257, 0);
            lblTime.text=_obj.time;
            
            [lblTime sizeToFit];
            
            float topHeight=0;
            float topY=lblTime.l_v_y+lblTime.l_v_h+5;
            
            bool hasVideo=false;
            if(_obj.video.length>0 && _obj.videoHeightForNoti.floatValue>0)
            {
                hasVideo=true;
                topHeight=_obj.videoHeightForNoti.floatValue;
                [videoContain l_v_setH:_obj.videoHeightForNoti.floatValue];
                
                if(!isCalculatingSuggestHeight)
                    [imgvVideoThumbnail loadVideoThumbnailWithURL:_obj.videoThumbnail];
                
                imgvVideoThumbnail.hidden=false;
                movideBGView.hidden=false;
                videoContain.hidden=false;
            }
            else
            {
                videoContain.hidden=true;
            }
            
            if(!hasVideo && _obj.image.length>0 && _obj.imageHeightForNoti.floatValue>0)
            {
                topHeight=_obj.imageHeightForNoti.floatValue;
                [imgvImage l_v_setH:_obj.imageHeightForNoti.floatValue];
                
                if(!isCalculatingSuggestHeight)
                    [imgvImage loadUserNotificationContentWithURL:_obj.image];
                
                imgvImage.hidden=false;
            }
            else
            {
                imgvImage.hidden=true;
            }
            
            if(topHeight>0)
                topY+=topHeight+5;
            
            lblTitle.frame=CGRectMake(19, topY, 274, 0);
            lblTitle.attributedText=_obj.titleAttribute;
            
            [lblTitle sizeToFit];
            
            lblContent.hidden=false;
            lblContent.frame=CGRectMake(19, lblTitle.l_v_y+lblTitle.l_v_h+5, 274, 0);
            lblContent.attributedText=_obj.contentAttribute;
            
            [lblContent sizeToFit];
            
            lblTime.textColor=[UIColor blackColor];
            lblTitle.textColor=[UIColor blackColor];
            markUnreadView.hidden=true;
            avatarMaskView.hidden=true;
            
            _actions=_obj.actionsObjects;
            
            if(_actions.count>0)
            {
                tableButtons.hidden=false;
                tableButtons.frame=CGRectMake(0, lblContent.l_v_y+lblContent.l_v_h+5, 312, _obj.actionsHeight.floatValue);
                tableButtons.delegate=self;
                tableButtons.dataSource=self;
                [tableButtons reloadData];
                
                suggestHeight=tableButtons.l_v_y+tableButtons.l_v_h;
            }
            else
            {
                tableButtons.hidden=true;
                tableButtons.delegate=nil;
                tableButtons.dataSource=nil;
                [tableButtons reloadData];
                
                suggestHeight=lblContent.l_v_y+lblContent.l_v_h;
            }

            break;
    }
    
    [UIView setAnimationsEnabled:true];
    
    suggestHeight+=displayView.l_v_y;
    
    suggestHeight=MAX(58,suggestHeight);
}

-(void)userNotificationDetailButtonTableViewCellTouchedAction:(UserNotificationDetailButtonTableViewCell *)cell
{
    [self.delegate userNotificationDetailCellTouchedAction:self action:cell.action];
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

@implementation UITableView(UserNotificationDetailCell)

-(void)registerUserNotificationDetailCell
{
    [self registerNib:[UINib nibWithNibName:[UserNotificationDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationDetailCell reuseIdentifier]];
}

-(UserNotificationDetailCell *)userNotificationDetailCell
{
    return [self dequeueReusableCellWithIdentifier:[UserNotificationDetailCell reuseIdentifier]];
}

@end