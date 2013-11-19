//
//  ShopListCell.m
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListCell.h"
#import "Utility.h"
#import "Constant.h"

#define SHOP_LIST_CELL_CONTENT_FRAME CGRectMake(54, 17, 268, 34)
#define SHOP_LIST_CELL_SLIDE_FRAME CGRectMake(320, 0, 103, 54)

@implementation ShopListCell

-(void)loadContent
{
    
    imgvVoucher.hidden=rand()%2==0;
    imgvSGP.hidden=!imgvVoucher.hidden;
    
//    scroll.contentSize=CGSizeMake(scroll.l_v_w+(imgvLineVerContent.l_v_x-imgvLine.l_v_x), scroll.l_v_h);
//    scroll.scrollEnabled=true;
//    scroll.bounces=false;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pnt=scrollView.contentOffset;
  
    CGRect rect=SHOP_LIST_CELL_CONTENT_FRAME;
    
    rect.size.width-=pnt.x;
    lblContent.frame=rect;
    
    rect=SHOP_LIST_CELL_SLIDE_FRAME;
    rect.origin.x=lblContent.l_v_x+lblContent.l_v_w;
    
    slideView.frame=rect;
}

+(NSString *)reuseIdentifier
{
    return @"ShopListCell";
}

+(float)height
{
    return 55;
}

- (IBAction)btnLoveTouchUpInside:(id)sender {
    NSLog(@"love");
}

- (IBAction)btnShareTouchUpInside:(id)sender {
    NSLog(@"share");
}

@end
