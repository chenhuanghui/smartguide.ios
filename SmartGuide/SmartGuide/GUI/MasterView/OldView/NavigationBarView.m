//
//  NavigationBarView.m
//  SmartGuide
//
//  Created by XXX on 7/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NavigationBarView.h"
#import "Constant.h"
#import "Flags.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"

@implementation NavigationBarView
@synthesize delegate,searchDelegate;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"NavigationBarView" owner:nil options:nil] objectAtIndex:0];
    if (self) {
        lblTitle.text=@"";
    }
    
    if(NSFoundationVersionNumber<=NSFoundationVersionNumber_iOS_6_1)
    {
        searchView.center=CGPointMake(searchView.center.x, searchView.center.y-3);
    }
    
    txtSearch.leftViewMode=UITextFieldViewModeAlways;
    
    UIView *vvv=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, txtSearch.frame.size.height)];
    txtSearch.leftView=vvv;
    
    return self;
}

-(void)btnAvatarTouchUpInside:(UIButton *)sender
{
    [Flurry trackUserClickCollection];
    
    [delegate navigationBarUserCollection:sender];
}

-(void)btnFilterTouchUpInside:(UIButton *)sender
{
    [Flurry trackUserClickFilter];
    
    [delegate navigationBarFilter:sender];
}

-(void)btnMapTouchUpInside:(UIButton *)sender
{
    [Flurry trackUserClickMap];
    
    [delegate navigationBarMap:sender];
}

-(void)btnSearchTouchUpInside:(UIButton *)sender
{
    [Flurry trackUserClickSearch];
    
    [delegate navigationBarSearch:sender];
}

-(void)hideSearch
{
    containButtons.hidden=false;
    
    self.searchDelegate=nil;
    searchView.hidden=true;
    [txtSearch resignFirstResponder];
}

-(void)showSearchWithDelegate:(id<NavigationSearchDelegate>)_delegate
{
    containButtons.hidden=true;

    self.searchDelegate=_delegate;
    searchView.hidden=false;
    [txtSearch becomeFirstResponder];
}

-(void)setSearchKeyword:(NSString *)key
{
    txtSearch.text=key;
}

-(void)btnSettingTouchUpInside:(UIButton *)sender
{
    [delegate navigationBarSetting:sender];
}

-(void)btnListTouchUpInside:(UIButton *)sender
{
    [delegate navigationBarList:sender];
}

+(float)height
{
    return 37;
}

-(void)setNavigationTitle:(NSString *)title
{
    if([lblTitle.text isEqualToString:title])
        return;
    
    [self.layer removeAllAnimations];
    [lblTitle.layer removeAllAnimations];
    
    if(lblTitle.text)
        _previousTitle=[[NSString alloc] initWithString:lblTitle.text];
    
    [UIView animateWithDuration:DURATION_NAVI_TITLE
                     animations:^{
                         lblTitle.alpha = 0.0f;
                         lblTitle.text=[title uppercaseString];
                         lblTitle.alpha = 1.0f;
                     }];
}

-(void)backToPreviousTitle
{
    [UIView animateWithDuration:DURATION_NAVI_TITLE
                     animations:^{
                         lblTitle.alpha = 0.0f;
                         lblTitle.text = [_previousTitle uppercaseString];
                         lblTitle.alpha = 1.0f;
                     }];
}

-(void)showIconList
{
    //    btnList.alpha=0;
    //    btnMap.alpha=1;
    //    btnList.hidden=false;
    //
    //    [UIView animateWithDuration:DURATION_NAVI_ICON animations:^{
    //        btnMap.alpha=0;
    //        btnList.alpha=1;
    //    } completion:^(BOOL finished) {
    //        btnMap.hidden=true;
    //    }];
}

-(void)showIconMap
{
    //    btnFilter.alpha=1;
    //    btnMap.alpha=0;
    //    btnMap.hidden=false;
    //
    //    [UIView animateWithDuration:DURATION_NAVI_ICON animations:^{
    //        btnMap.alpha=1;
    //        btnFilter.alpha=0;
    //    } completion:^(BOOL finished) {
    //        btnFilter.hidden=true;
    //    }];
}

-(void)setLeftIcon:(NSArray *)icons
{
    
}

-(void)setRightIcon:(NSArray *)icons
{
    btnFilter.hidden=true;
    btnAvatar.hidden=true;
    btnList.hidden=true;
    btnMap.hidden=true;
    
    CGPoint pnts[3];
    pnts[0]=CGPointMake(206, -3);
    pnts[1]=CGPointMake(237, -3);
    pnts[2]=CGPointMake(271, -3);
    
    NSMutableArray *array=[NSMutableArray arrayWithArray:icons];
    for(int i=2;i>=0;i--)
    {
        if(array.count>0)
        {
            UIButton *btn=[self buttonWithItem:[[array lastObject] integerValue]];
            CGRect rect=btn.frame;
            rect.origin=pnts[i];
            btn.frame=rect;
            btn.hidden=false;
            btn.enabled=true;
            
            [array removeLastObject];
        }
    }
    
    if(icons.count==3 && lblTitle.text.length>=16)
    {
        lblTitle.frame=CGRectMake(68, 0, 150, 37);
    }
    else
    {
        CGRect rect=self.frame;
        rect.origin=CGPointZero;
        lblTitle.frame=rect;
    }
}

-(UIButton*) buttonWithItem:(int) item
{
    if(item==ITEM_COLLECTION)
        return btnAvatar;
    else if(item==ITEM_CATALOGUE)
        return btnList;
    else if(item==ITEM_FILTER)
        return btnFilter;
    else if(item==ITEM_LIST)
        return btnList;
    else if(item==ITEM_MAP)
        return btnMap;
    else if(item==ITEM_SEARCH)
        return btnSearch;
    else if(item==ITEM_SETTING)
        return btnSetting;
    
    return nil;
}

-(void)setDisableRighIcon:(NSArray *)icons
{
    for(NSNumber *num in icons)
    {
        UIButton *btn=[self buttonWithItem:num.integerValue];
        
        if(btn)
            btn.enabled=false;
    }
}

-(void)enableCancelButton
{
    btnCancel.enabled=true;
}

-(BOOL)endEditing:(BOOL)force
{
    bool endE=[super endEditing:force];
    if(force)
        [self enableCancelButton];
    
    return endE;
}

-(void)enableButton:(enum NAVIGATIONBAR_ITEM)button enabled:(bool)isEnable
{
    [self buttonWithItem:button].userInteractionEnabled=isEnable;
}

- (IBAction)btnCancelTouchUpInside:(id)sender {
    [self.searchDelegate navigationSearchCancel:txtSearch];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchDelegate navigationSearchSearchClicked:textField];
    
    return true;
}

@end