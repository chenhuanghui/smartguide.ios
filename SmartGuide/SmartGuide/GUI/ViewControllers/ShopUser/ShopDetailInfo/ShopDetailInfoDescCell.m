//
//  ShopDetailInfoDescCell.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopDetailInfoDescCell.h"
#import "Utility.h"
#import "Shop.h"

#define SHOP_DETAIL_INFO_DESC_HEIGHT_MAX_NORMAL 80.f

@implementation ShopDetailInfoDescCell
@synthesize delegate, suggestHeight;

-(void)loadWithShop:(Shop *)shop mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode
{
    _shop=shop;
    _mode=mode;
    _markedAnimation=false;
}

-(void)markedAnimation
{
    _markedAnimation=true;
}

-(void)animationWithMode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode duration:(float)duration
{
    switch (mode) {
        case SHOP_DETAIL_INFO_DESCRIPTION_NORMAL:
        {
            lbl.numberOfLines=3;
            [lbl l_v_setW:274];
            [lbl sizeToFit];
            
            float height=lbl.l_v_h;
            
            lbl.numberOfLines=0;
            [lbl l_v_setW:274];
            [lbl sizeToFit];
            
            [UIView animateWithDuration:duration animations:^{
                [lblView l_v_setH:height];
                blur.alpha=1;
                [blur l_v_setY:lblView.l_v_y+lblView.l_v_h-blur.l_v_h];
                [btn l_v_setY:lblView.l_v_y+lblView.l_v_h];
                
            } completion:^(BOOL finished) {
                lbl.numberOfLines=3;
                [lbl l_v_setW:274];
                [lbl sizeToFit];
                [btn setTitle:@"Xem thêm" forState:UIControlStateNormal];
            }];
        }
            break;
            
        case SHOP_DETAIL_INFO_DESCRIPTION_FULL:
            lbl.numberOfLines=0;
            [lbl l_v_setW:274];
            [lbl sizeToFit];
            
            [UIView animateWithDuration:duration animations:^{
                [lblView l_v_setH:lbl.l_v_h];
                [btn l_v_setY:lbl.l_v_y+lbl.l_v_h];
                [blur l_v_setY:lblView.l_v_y+lblView.l_v_h-blur.l_v_h];
                blur.alpha=0;
            } completion:^(BOOL finished) {
                [btn setTitle:@"Rút gọn" forState:UIControlStateNormal];
            }];
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_markedAnimation)
        return;
    
    NSDictionary *attr=@{NSFontAttributeName:lbl.font
                         , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]};
    lbl.attributedText=[[NSAttributedString alloc] initWithString:_shop.desc attributes:attr];
    
    [lbl l_v_setW:274];
    
    switch (_mode) {
        case SHOP_DETAIL_INFO_DESCRIPTION_FULL:
            lbl.numberOfLines=0;
            
            [lbl sizeToFit];
            
            btn.hidden=false;
            [btn setTitle:@"Rút gọn" forState:UIControlStateNormal];
            blur.alpha=0;
            
            break;
            
        case SHOP_DETAIL_INFO_DESCRIPTION_NORMAL:
            lbl.numberOfLines=0;
            [lbl sizeToFit];
            float maxHeight=lbl.l_v_h;
            
            lbl.numberOfLines=3;
            [lbl l_v_setW:274];
            [lbl sizeToFit];
            
            float height=lbl.l_v_h;
            
            [btn setTitle:@"Xem thêm" forState:UIControlStateNormal];
            
            //Chiều cao của text khi full <= chiều cao khi bình thường->không hiển thị read more
            if(maxHeight<=height)
            {
                btn.hidden=true;
                blur.alpha=0;
            }
            else
            {
                btn.hidden=false;
                blur.alpha=1;
            }
            
            break;
    }
    
    if(_markedAnimation)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            [lblView l_v_setH:lbl.l_v_h];
            [blur l_v_setY:lbl.l_v_y+lbl.l_v_h-blur.l_v_h];
            [btn l_v_setY:lbl.l_v_y+lbl.l_v_h];
        }];
    }
    else
    {
        [lblView l_v_setH:lbl.l_v_h];
        [blur l_v_setY:lbl.l_v_y+lbl.l_v_h-blur.l_v_h];
        [btn l_v_setY:lbl.l_v_y+lbl.l_v_h];
    }
    
    _markedAnimation=false;
    
    if(btn.hidden)
    {
        suggestHeight=lbl.l_v_y+lbl.l_v_h;
    }
    else
    {
        suggestHeight=btn.l_v_y+btn.l_v_h;
    }
}

- (IBAction)btnReadTouchUpInside:(id)sender {
    switch (_mode) {
        case SHOP_DETAIL_INFO_DESCRIPTION_NORMAL:
            [self.delegate shopDetailInfoDescCellTouchedReadMore:self];
            break;
            
        case SHOP_DETAIL_INFO_DESCRIPTION_FULL:
            [self.delegate shopDetailInfoDescCellTouchedReadLess:self];
            break;
    }
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoDescCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    blur.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
}

-(bool)canReadMore
{
    return !btn.hidden;
}

@end

@implementation UITableView(ShopDetailInfoDescCell)

-(void)registerShopDetailInfoDescCell
{
    [self registerNib:[UINib nibWithNibName:[ShopDetailInfoDescCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoDescCell reuseIdentifier]];
}

-(ShopDetailInfoDescCell *)shopDetailInfoDescCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopDetailInfoDescCell reuseIdentifier]];
}

@end