//
//  TextField.m
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TextField.h"
#import "Utility.h"

@implementation TextField
@synthesize leftViewType, rightViewType;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self textChanged:self];
}

-(void) textChanged:(id) sender
{
    switch (self.rightViewType) {
        case TEXTFIELD_RIGHTVIEW_CLEAR:
            self.rightView.hidden=self.text.length==0;
            break;
            
        case TEXTFIELD_RIGHTVIEW_NONE:
        case TEXTFIELD_RIGHTVIEW_LOCATION:
            break;
    }
}

-(void)setLeftViewType:(enum TEXTFIELD_LEFTVIEW_TYPE)leftViewType_
{
    leftViewType=leftViewType_;
    
    switch (leftViewType) {
        case TEXTFIELD_LEFTVIEW_SEARCH:
        {
            UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search.png"]];
            imgv.contentMode=UIViewContentModeCenter;
            [imgv l_v_setS:CGSizeMake(38, 38)];
            self.leftView=imgv;
            self.leftViewMode=UITextFieldViewModeAlways;
        }
            break;
            
        case TEXTFIELD_LEFTVIEW_LOCATION:
        {
            UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location.png"]];
            imgv.contentMode=UIViewContentModeCenter;
            [imgv l_v_setS:CGSizeMake(38, 38)];
            self.leftView=imgv;
            self.leftViewMode=UITextFieldViewModeAlways;
        }
            break;
            
        case TEXTFIELD_LEFTVIEW_NONE:
        {
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
            view.backgroundColor=[UIColor clearColor];
            
            self.leftView=view;
            self.leftViewMode=UITextFieldViewModeAlways;
        }
            break;
    }
}

-(void) btnRightTouchUpInside:(id) sender
{
    if([self.delegate respondsToSelector:@selector(textFieldTouchedRightView:)])
        [self.delegate textFieldTouchedRightView:self];
}

-(void)setRightViewType:(enum TEXTFIELD_RIGHTVIEW_TYPE)rightViewType_
{
    rightViewType=rightViewType_;
    
    switch (rightViewType) {
        case TEXTFIELD_RIGHTVIEW_CLEAR:
        {
            UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_close_search.png"]];
            imgv.contentMode=UIViewContentModeCenter;
            [imgv l_v_setS:CGSizeMake(38, 38)];
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn l_v_setS:CGSizeMake(38, 38)];
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(btnRightTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
            view.backgroundColor=[UIColor clearColor];
            
            [view addSubview:imgv];
            [view addSubview:btn];
            
            self.rightView=view;
            self.rightViewMode=UITextFieldViewModeAlways;
        }
            break;
            
        case TEXTFIELD_RIGHTVIEW_LOCATION:
        {
            UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location.png"]];
            imgv.contentMode=UIViewContentModeCenter;
            [imgv l_v_setS:CGSizeMake(38, 38)];
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn l_v_setS:CGSizeMake(38, 38)];
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(btnRightTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
            view.backgroundColor=[UIColor clearColor];
            
            [view addSubview:imgv];
            [view addSubview:btn];
            
            self.rightView=view;
            self.rightViewMode=UITextFieldViewModeAlways;
        }
            break;
            
        case TEXTFIELD_RIGHTVIEW_NONE:
        {
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
            view.backgroundColor=[UIColor clearColor];
            
            self.rightView=view;
            self.rightViewMode=UITextFieldViewModeAlways;
        }
            break;
    }
}

@end

@implementation SearchTextField

-(enum TEXTFIELD_DISPLAY_TYPE)displayType
{
    return TEXTFIELD_DISPLAY_TYPE_SEARCH;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_search_left.png"]];
    [imgv l_v_setS:CGSizeMake(19, 38)];
    imgv.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
    
    [self addSubview:imgv];
    
    imgvLeft=imgv;
    
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(19, 0, self.l_v_w-19*2, 38);
    view.contentMode=UIViewContentModeRedraw;
    view.autoresizesSubviews=false;
    view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_search_mid.png"]];
    view.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    view.userInteractionEnabled=false;
    
    [self addSubview:view];
    
    midView=view;
    
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_search_right.png"]];
    imgv.frame=CGRectMake(self.l_v_w-19, 0, 19, 38);
    imgv.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:imgv];
    
    imgvRight=imgv;
}

@end

@implementation HomeTextField
@synthesize refreshState;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizesSubviews=true;
    self.font=FONT_SIZE_NORMAL(14);
    
    imgvLeft.autoresizingMask=UIViewAutoresizingNone;
    imgvRight.autoresizingMask=UIViewAutoresizingNone;
    midView.autoresizingMask=UIViewAutoresizingNone;
    
    _distanceMinY_Y=-1;
    [self setLeftViewType:TEXTFIELD_LEFTVIEW_SEARCH];
    [self setRightViewType:TEXTFIELD_RIGHTVIEW_NONE];
    
    refreshState=TEXTFIELD_REFRESH_STATE_NORMAL;
    _startRotationY=-1;
    
//    float icon_refresh_width=19;
    UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh.png"]];
    imgv.frame=CGRectMake(0, 0, self.l_v_w, self.l_v_h);
    imgv.autoresizingMask=UIViewAutoresizingAll();
    imgv.contentMode=UIViewContentModeCenter;
    imgv.hidden=true;
    
    [self addSubview:imgv];
    imgvRefresh=imgv;
}

-(void) animationRefreshing:(float) angle
{
    if(self.refreshState!=TEXTFIELD_REFRESH_STATE_REFRESHING)
        return;
    
    __weak HomeTextField *wSelf=self;
    
    [UIView animateWithDuration:0.15f animations:^{
        imgvRefresh.transform=CGAffineTransformMakeRotation(angle);
    } completion:^(BOOL finished) {
        if(wSelf)
            [wSelf animationRefreshing:angle+M_PI_4];
    }];
}

-(void)tableDidScroll:(UITableView *)table
{
    if(refreshState==TEXTFIELD_REFRESH_STATE_REFRESHING
       || refreshState==TEXTFIELD_REFRESH_STATE_DONE)
    {
        CGRect rect=self.frame;
        rect.size.width=self.minimumWidth;
        rect.origin.x=(UIScreenSize().width-rect.size.width)/2;
        self.frame=rect;
        return;
    }
    
    if(CGRectIsEmpty(_txtFrame))
        _txtFrame=self.frame;
    if(_distanceMinY_Y==-1)
    {
        _distanceMinY_Y=_txtFrame.origin.y-self.minimumY;
    }
    
    float y=table.offsetYWithInsetTop;
    float perY=y/_distanceMinY_Y;
    float txtY=_txtFrame.origin.y-y;
    txtY=MAX(self.minimumY,txtY);
    
    [self l_v_setY:txtY];
    
    if(y>0)
    {
        imgvRefresh.hidden=true;
        
        if(y<_distanceMinY_Y)
        {
            CGRect rect=self.frame;
            rect.size.width=_txtFrame.size.width+perY*(self.maximumWidth-_txtFrame.size.width);
            rect.origin.x=_txtFrame.origin.x-(perY*(self.maximumWidth-_txtFrame.size.width))/2+4.f*perY;
            
            self.frame=rect;
        }
        else
        {
            CGRect rect=self.frame;
            rect.origin.x=(UIScreenSize().width-self.maximumWidth)/2+MIN(4.f*perY,4);
            rect.origin.y=self.minimumY;
            rect.size.width=self.maximumWidth;
            
            self.frame=rect;
        }
    }
    else
    {
        CGRect rect=_txtFrame;
        float inscreaseY=(rect.size.width*perY)*1.5f;
        
        if(rect.size.width+inscreaseY<self.minimumWidth)
        {
            if(_startRotationY==-1)
                _startRotationY=self.l_v_y;
            
            self.leftViewMode=UITextFieldViewModeNever;
            imgvRefresh.hidden=false;
            
            float angle=DEGREES_TO_RADIANS(self.l_v_y-_startRotationY);
            angle*=4.5f;

            if(angle>M_PI*2)
            {
                imgvRefresh.transform=CGAffineTransformIdentity;
                imgvRefresh.image=[UIImage imageNamed:@"icon_refresh_blue.png"];
                refreshState=TEXTFIELD_REFRESH_STATE_REFRESHING;
                _isMarkRefreshDone=false;
                
                [self animationRefreshing:M_PI*2];
                [self.delegate textFieldNeedRefresh:self];
            }
            else
            {
                imgvRefresh.transform=CGAffineTransformMakeRotation(M_PI+angle);
            }
            
            rect.size.width=self.minimumWidth;
            rect.origin.x=(UIScreenSize().width-rect.size.width)/2;
            
            self.frame=rect;
        }
        else
        {
            self.leftViewMode=UITextFieldViewModeAlways;
            imgvRefresh.hidden=true;
            imgvRefresh.transform=CGAffineTransformIdentity;
            
            rect.size.width+=inscreaseY;

            rect.size.width=MAX(self.minimumWidth,rect.size.width);
            rect.origin.x-=inscreaseY/2;
            
            self.frame=rect;
        }
    }
    
    if(!_text)
        _text=self.text;
    
    if(self.l_v_w<95)
        self.text=@"";
    else
        self.text=_text;
}

-(void)tableWillBeginDragging:(UITableView *)table
{
    _isUserDragging=true;
}

-(void)tableDidEndDecelerating:(UITableView *)table
{
    _isUserDragging=false;
    
    if(self.refreshState==TEXTFIELD_REFRESH_STATE_DONE)
        [self callRefreshFinished:table];
}

-(void)tableDidEndDragging:(UITableView *)table willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        _isUserDragging=false;
        
        if(self.refreshState==TEXTFIELD_REFRESH_STATE_DONE)
            [self callRefreshFinished:table];
    }
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [imgvLeft l_v_setX:0];
    [imgvRight l_v_setX:frame.size.width-imgvRight.l_v_w];
    [midView l_v_setW:MAX(0,frame.size.width-imgvLeft.l_v_w-imgvRight.l_v_w)];
}

-(void)markRefreshDone:(UITableView *)table
{
    _isMarkRefreshDone=true;
    refreshState=TEXTFIELD_REFRESH_STATE_DONE;
    table.userInteractionEnabled=false;
    
    imgvRefresh.transform=CGAffineTransformIdentity;
    imgvRefresh.image=[UIImage imageNamed:@"icon_refresh_done.png"];
    
    [self callRefreshFinished:table];
}

-(void) callRefreshFinished:(UITableView*) table
{
    if(_isMarkRefreshDone && !_isUserDragging)
    {
        _isMarkRefreshDone=false;
        table.userInteractionEnabled=true;
        refreshState=TEXTFIELD_REFRESH_STATE_NORMAL;
        imgvRefresh.image=[UIImage imageNamed:@"icon_refresh.png"];
        
        [self.delegate textFieldRefreshFinished:self];
    }
}

@end

@implementation UserPromotionTextField



@end