//
//  UserNotificationCell.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationCell.h"
#import <CoreText/CoreText.h>
#import "DataManager.h"
#import "UserNotification.h"

@interface UserNotificationCell()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation UserNotificationCell

-(void)loadWithUserNotification:(UserNotification *)obj
{
    _obj=obj;
    
    lblContent.attributedText=obj.displayContentAttribute;
    
    NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
    paraStyle.alignment=NSTextAlignmentLeft;
    
    lblTime.text=obj.time;
    lblNumber.text=obj.displayCount;
    
    [lblContent l_v_setH:obj.displayContentHeight.floatValue];
    
    if(obj.enumStatus==NOTIFICATION_STATUS_UNREAD && obj.highlightUnread.boolValue)
    {
        displayContentView.backgroundColor=[UIColor whiteColor];
        lineView.backgroundColor=COLOR255(61, 165, 254, 255);
    }
    else
    {
        [lblContent setTextColor:[UIColor grayColor]];
        displayContentView.backgroundColor=COLOR255(205, 205, 205, 255);
        lineView.backgroundColor=COLOR255(146, 146, 146, 255);
    }
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(leftView.l_v_w+rightView.l_v_w, 0);
    
    //Chỉ user có tài khoản mới được phép remove notification
    scroll.scrollEnabled=currentUser().enumDataMode==USER_DATA_FULL;
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

+(NSString *)reuseIdentifier
{
    return @"UserNotificationCell";
}

+(float)heightWithUserNotification:(UserNotification *)obj
{
    float height=56;
    
    if(!obj.displayContentAttribute)
    {
        obj.displayContentAttribute=[NSMutableAttributedString new];
        
        NSAttributedString *attStr=[[NSAttributedString alloc] initWithString:[obj.sender stringByAppendingString:@" "]
                                                                   attributes:@{
                                                                                NSFontAttributeName:FONT_SIZE_BOLD(13)
                                                                                , NSForegroundColorAttributeName:[UIColor darkTextColor]}];
        [obj.displayContentAttribute appendAttributedString:attStr];
        
        attStr=[[NSAttributedString alloc] initWithString:obj.content
                                               attributes:@{
                                                            NSFontAttributeName:FONT_SIZE_NORMAL(13)
                                                            , NSForegroundColorAttributeName:[UIColor darkTextColor]}];
        
        [obj.displayContentAttribute appendAttributedString:attStr];
    }
    
    if(obj.displayContentHeight.floatValue==-1)
    {
        CGRect rect=[obj.displayContentAttribute boundingRectWithSize:CGSizeMake(264, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil];
        rect.size.height+=10;
        
        if(rect.size.height<36)
            rect.size.height=21;
        else
            rect.size.height=50;
        
        obj.displayContentHeight=@(rect.size.height);
    }
    
    height+=obj.displayContentHeight.floatValue;
    
    return height;
}

- (IBAction)btnRemoveTouchUpInside:(id)sender {
    [self removeObserverHighlightUnread];
    [self.delegate userNotificationCellTouchedRemove:self obj:_obj];
}

-(UserNotification *)userNotification
{
    return _obj;
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
    [self.delegate userNotificationCellTouchedDetail:self obj:_obj];
}

-(void)tableWillDisplayCell
{
    [self addObserverHighlightUnread];
}

-(void)tableDidEndDisplayCell
{
    [self removeObserverHighlightUnread];
}

-(void) addObserverHighlightUnread
{
    _isAddedObserverHighlightUnread=true;
    [_obj addObserver:self forKeyPath:UserNotification_HighlightUnread options:NSKeyValueObservingOptionNew context:nil];
}

-(void) removeObserverHighlightUnread
{
    if(_isAddedObserverHighlightUnread && _obj.observationInfo)
    {
        [_obj removeObserver:self forKeyPath:UserNotification_HighlightUnread];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:UserNotification_HighlightUnread])
    {
        [self loadWithUserNotification:_obj];
    }
}

-(void)dealloc
{
    [self removeObserverHighlightUnread];
}

@end

@implementation ScrollUserNotification

-(void)setContentOffset:(CGPoint)contentOffset
{
    contentOffset.x=MAX(0,contentOffset.x);
    
    [super setContentOffset:contentOffset];
}

@end