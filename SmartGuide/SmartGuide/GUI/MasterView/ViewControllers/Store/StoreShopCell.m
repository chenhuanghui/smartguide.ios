//
//  StoreShopItemCell.m
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreShopCell.h"
#import "Utility.h"

@implementation StoreShopCell

-(id)init
{
    self=[[NSBundle mainBundle] loadNibNamed:[StoreShopCell reuseIdentifier] owner:nil options:nil][0];
    
    return self;
}

-(void)loadWithStore:(StoreShop *)store
{
    indicator.hidden=true;
    
    if(store)
    {
        [self emptyCell:false];
    }
    else
    {
        [self emptyCell:true];
    }
}

-(void)emptyCell:(bool)isEmpty
{
    for(UIView *v in self.subviews)
    {
        if(v==imgvLineVer || v==imgvHor1 || v==imgvHor2 || v==indicator)
            continue;
        
        v.hidden=isEmpty;
    }
}

-(void)loadingCell
{
    [self emptyCell:true];
    
    indicator.alpha=0;
    indicator.hidden=false;
    
    [indicator startAnimating];
    
    [UIView animateWithDuration:0.1f animations:^{
        indicator.alpha=1;
    }];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
    {
        imgvLineVer.hidden=self.l_v_w>[StoreShopCell width];
        [topRightView l_v_addX:(self.l_v_w>[StoreShopCell width]?5:0)];
    }
}

+(NSString *)reuseIdentifier
{
    return @"StoreShopCell";
}

+(float)height
{
    return 131;
}

+(float)width
{
    return 163.f;
}

+(CGSize)smallSize
{
    return CGSizeMake(163, 131);
}

+(CGSize)bigSize
{
    return CGSizeMake(320, 131);
}

@end
