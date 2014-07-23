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
@synthesize suggestHeight;

-(void)loadWithUserNotification:(UserNotification *)obj
{
    _obj=obj;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_obj.displayContentAttribute)
    {
        _obj.displayContentAttribute=[NSMutableAttributedString new];
        
        NSAttributedString *attStr=[[NSAttributedString alloc] initWithString:[_obj.sender stringByAppendingString:@" "]
                                                                   attributes:@{
                                                                                NSFontAttributeName:FONT_SIZE_BOLD(13)
                                                                                , NSForegroundColorAttributeName:[UIColor darkTextColor]}];
        [_obj.displayContentAttribute appendAttributedString:attStr];
        
        attStr=[[NSAttributedString alloc] initWithString:_obj.content
                                               attributes:@{
                                                            NSFontAttributeName:FONT_SIZE_NORMAL(13)
                                                            , NSForegroundColorAttributeName:[UIColor darkTextColor]}];
        
        [_obj.displayContentAttribute appendAttributedString:attStr];
    }
    
    lblContent.attributedText=_obj.displayContentAttribute;
    lblContent.numberOfLines=2;
    lblContent.frame=CGRectMake(20, 17, 264, 0);
    
    [lblContent sizeToFit];
    
    lblTime.text=_obj.time;
    lblNumber.text=_obj.displayCount;
    
    if(_obj.enumStatus==NOTIFICATION_STATUS_UNREAD && _obj.highlightUnread.boolValue)
    {
        displayContentView.backgroundColor=[UIColor whiteColor];
        lineView.backgroundColor=COLOR255(61, 165, 254, 255);
        markUnreadView.hidden=false;
    }
    else
    {
        [lblContent setTextColor:[UIColor grayColor]];
        displayContentView.backgroundColor=COLOR255(205, 205, 205, 255);
        lineView.backgroundColor=COLOR255(146, 146, 146, 255);
        markUnreadView.hidden=true;
    }
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(leftView.l_v_w+rightView.l_v_w, 0);
    
    //Chỉ user có tài khoản mới được phép remove notification
    scroll.scrollEnabled=currentUser().enumDataMode==USER_DATA_FULL;
    
    suggestHeight=lblContent.l_v_h+56;
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

- (IBAction)btnRemoveTouchUpInside:(id)sender {
    [self removeObserver];
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
    [self addObserver];
}

-(void)tableDidEndDisplayCell
{
    [self removeObserver];
}

-(void) addObserver
{
    _isAddedObserver=true;
    [_obj addObserver:self forKeyPath:UserNotification_HighlightUnread options:NSKeyValueObservingOptionNew context:nil];
    [_obj addObserver:self forKeyPath:UserNotification_NumberUnread options:NSKeyValueObservingOptionNew context:nil];
}

-(void) removeObserver
{
    if(_isAddedObserver && _obj.observationInfo)
    {
        [_obj removeObserver:self forKeyPath:UserNotification_HighlightUnread];
        [_obj removeObserver:self forKeyPath:UserNotification_NumberUnread];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self loadWithUserNotification:_obj];
}

-(void)dealloc
{
    [self removeObserver];
}

@end

@implementation ScrollUserNotification

-(void)setContentOffset:(CGPoint)contentOffset
{
    contentOffset.x=MAX(0,contentOffset.x);
    
    [super setContentOffset:contentOffset];
}

@end

@implementation UITableView(UserNotificationCell)

-(void)registerUserNotificationCell
{
    [self registerNib:[UINib nibWithNibName:[UserNotificationCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationCell reuseIdentifier]];
}

-(UserNotificationCell *)userNotificationCell
{
    return [self dequeueReusableCellWithIdentifier:[UserNotificationCell reuseIdentifier]];
}

@end