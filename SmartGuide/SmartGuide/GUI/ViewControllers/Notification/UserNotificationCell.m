//
//  UserNotificationCell.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationCell.h"
#import <CoreText/CoreText.h>

@interface UserNotificationCell()<UIScrollViewDelegate>

@end

@implementation UserNotificationCell

-(void)loadWithUserNotification:(UserNotification *)obj
{
    _obj=obj;
    
    lblContent.attributedText=obj.contentAttribute;
    lblTime.text=obj.time;
    
    switch (obj.enumStatus) {
        case USER_NOTIFICATION_STATUS_UNREAD:
            displayContentView.backgroundColor=[UIColor whiteColor];
            lineView.backgroundColor=[UIColor color255WithRed:61 green:165 blue:254 alpha:255];
            break;
            
        case USER_NOTIFICATION_STATUS_READ:
            displayContentView.backgroundColor=[UIColor color255WithRed:205 green:205 blue:205 alpha:255];
            lineView.backgroundColor=[UIColor color255WithRed:146 green:146 blue:146 alpha:255];
            break;
    }
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(leftView.l_v_w+rightView.l_v_w, 0);
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

+(NSMutableAttributedString*) contentAttribute:(UserNotification*) obj
{
    if(!obj)
        return [[NSMutableAttributedString alloc] initWithString:@"" attributes:nil];
    
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:[UIFont fontWithName:@"Avenir-Roman" size:13] forKey:NSFontAttributeName];
    
    if(obj.enumStatus==USER_NOTIFICATION_STATUS_UNREAD)
        [dict setObject:obj.highlightUnread.boolValue?[UIColor darkTextColor]:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    else
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString *attStr=[[NSMutableAttributedString alloc] initWithString:obj.content attributes:dict];
    
    NSArray *highlightIndex=obj.highlightIndex;
    int count=highlightIndex.count;
    
    if(count%2==0)
    {
        for(int i=0;i<count;i+=2)
        {
            [dict setObject:[UIFont fontWithName:@"Avenir-Heavy" size:13] forKey:NSFontAttributeName];
            
            NSRange range=NSMakeRange([highlightIndex[i] integerValue], [highlightIndex[i+1] integerValue]);
            [attStr setAttributes:dict range:range];
        }
    }
    
    return attStr;
}

+(float)heightWithUserNotification:(UserNotification *)obj
{
    float height=56;
    
    if(!obj.contentAttribute)
    {
        obj.contentAttribute=[UserNotificationCell contentAttribute:obj];
    }
    
    if(obj.contentHeight.floatValue==-1)
    {
        CGRect rect=[obj.contentAttribute boundingRectWithSize:CGSizeMake(264, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil];
        rect.size.height+=10;
        
        if(rect.size.height<36)
            rect.size.height=21;
        else
            rect.size.height=50;
        
        obj.contentHeight=@(rect.size.height);
    }
    
    height+=obj.contentHeight.floatValue;
    
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
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    [leftView addGestureRecognizer:tap];
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    [self.delegate userNotificationCellTouchedDetail:self obj:_obj];
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
        NSLog(@"observeValueForKeyPath %@",_obj);
        _obj.contentAttribute=[UserNotificationCell contentAttribute:_obj];
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