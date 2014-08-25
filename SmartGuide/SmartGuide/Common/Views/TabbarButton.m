//
//  TabbarButton.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabbarButton.h"
#import "Utility.h"

@implementation TabbarButton

NSString *tabbarButtonTitle(enum TABBAR_BUTTON_TYPE type)
{
    switch (type) {
        case TABBAR_BUTTON_TYPE_USER:
            return @"Cá nhân";
            
        case TABBAR_BUTTON_TYPE_INBOX:
            return @"Thông báo";
            
        case TABBAR_BUTTON_TYPE_SCAN:
            return @"Tương tác";
            
        case TABBAR_BUTTON_TYPE_SEARCH:
            return @"Tìm kiếm";
            
        case TABBAR_BUTTON_TYPE_HOME:
            return @"Khám phá";
            
        case TABBAR_BUTTON_TYPE_NONE:
            return @"";
    }
}

UIImage *tabbarButtonImage(enum TABBAR_BUTTON_TYPE type, bool selected)
{
    switch (type) {
        case TABBAR_BUTTON_TYPE_SCAN:
            return [UIImage imageNamed:@"button_interaction"];
            
        case TABBAR_BUTTON_TYPE_HOME:
            return selected?[UIImage imageNamed:@"button_explore_active"]:[UIImage imageNamed:@"button_explore"];
            
        case TABBAR_BUTTON_TYPE_INBOX:
            return selected?[UIImage imageNamed:@"button_notification_active"]:[UIImage imageNamed:@"button_notification"];
            
        case TABBAR_BUTTON_TYPE_SEARCH:
            return selected?[UIImage imageNamed:@"button_search_active"]:[UIImage imageNamed:@"button_search"];
            
        case TABBAR_BUTTON_TYPE_USER:
            return selected?[UIImage imageNamed:@"button_user_active"]:[UIImage imageNamed:@"button_user"];
            
        case TABBAR_BUTTON_TYPE_NONE:
            return nil;
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self settings];
}

-(void) settings
{
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height+1)];
    view.backgroundColor=[UIColor color255WithRed:56 green:55 blue:53 alpha:255];
    view.alpha=1;
    view.userInteractionEnabled=false;
    view.center=CGPointMake(view.center.x, view.frame.size.height+view.frame.size.height/2);
    
    if(self.subviews.count==0)
        [self addSubview:view];
    else
        [self insertSubview:view atIndex:0];
    
    _bgView=view;
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:rect];
    lbl.numberOfLines=1;
    lbl.font=FONT_SIZE_MEDIUM(10);
    lbl.textColor=[UIColor color255WithRed:153 green:153 blue:153 alpha:255];
    lbl.textAlignment=NSTextAlignmentCenter;
    [lbl sizeToFit];
    
    self.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 12, 0);
    
    [self alignText];
    
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateHighlighted];
    [self setTitle:@"" forState:UIControlStateSelected];
    
    [self addSubview:lbl];
    
    _lblText=lbl;
}

-(void) alignText
{
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    _lblText.frame=rect;
    [_lblText sizeToFit];
    
    rect.origin=CGPointMake(0, self.frame.size.height-_lblText.frame.size.height-3);
    rect.size.height=_lblText.frame.size.height;
    _lblText.frame=rect;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_bgView)
    {
        [self sendSubviewToBack:_bgView];
    }
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self animationBGView:highlighted];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self animationBGView:selected];
}

-(void) animationBGView:(bool) show
{
    float y=0;
    if(_tabbarButtonType==TABBAR_BUTTON_TYPE_SCAN)
        y=0;
    
    [UIView animateWithDuration:0.15f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _bgView.center=show?CGPointMake(_bgView.frame.size.width/2, _bgView.frame.size.height/2+y):CGPointMake(_bgView.center.x, _bgView.frame.size.height+_bgView.frame.size.height/2);;
    } completion:nil];
}

-(void)setTabbarButtonType:(enum TABBAR_BUTTON_TYPE)tabbarButtonType
{
    _tabbarButtonType=tabbarButtonType;
    
    _lblText.text=tabbarButtonTitle(_tabbarButtonType);
    [self alignText];
    
    switch (_tabbarButtonType) {
        case TABBAR_BUTTON_TYPE_SCAN:
            [self setImage:tabbarButtonImage(_tabbarButtonType, false) forState:UIControlStateNormal];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateSelected];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateHighlighted];
            break;
            
        case TABBAR_BUTTON_TYPE_HOME:
            [self setImage:tabbarButtonImage(_tabbarButtonType, false) forState:UIControlStateNormal];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateSelected];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateHighlighted];
            break;
            
        case TABBAR_BUTTON_TYPE_USER:
            [self setImage:tabbarButtonImage(_tabbarButtonType, false) forState:UIControlStateNormal];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateSelected];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateHighlighted];
            break;
            
        case TABBAR_BUTTON_TYPE_INBOX:
            [self setImage:tabbarButtonImage(_tabbarButtonType, false) forState:UIControlStateNormal];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateSelected];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateHighlighted];
            break;
            
        case TABBAR_BUTTON_TYPE_SEARCH:
            [self setImage:tabbarButtonImage(_tabbarButtonType, false) forState:UIControlStateNormal];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateSelected];
            [self setImage:tabbarButtonImage(_tabbarButtonType, true) forState:UIControlStateHighlighted];
            break;
            
        default:
            [self setImage:nil forState:UIControlStateNormal];
            [self setImage:nil forState:UIControlStateSelected];
            [self setImage:nil forState:UIControlStateHighlighted];
            break;
    }
}

@end
