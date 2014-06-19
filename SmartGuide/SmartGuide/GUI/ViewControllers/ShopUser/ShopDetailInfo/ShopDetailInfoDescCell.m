//
//  ShopDetailInfoDescCell.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopDetailInfoDescCell.h"
#import "Utility.h"

#define SHOP_DETAIL_INFO_DESC_HEIGHT_MAX_NORMAL 80.f

@implementation ShopDetailInfoDescCell
@synthesize delegate;

-(void)loadWithShop:(Shop *)shop mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode
{
    _mode=mode;
    lbl.text=shop.desc;
    
    if(mode==SHOP_DETAIL_INFO_DESCRIPTION_NORMAL)
    {
        if(shop.descHeight.floatValue>SHOP_DETAIL_INFO_DESC_HEIGHT_MAX_NORMAL)
        {
            [btn setTitle:@"Xem thêm" forState:UIControlStateNormal];
            btn.hidden=false;
            blur.hidden=false;
        }
        else
        {
            btn.hidden=true;
            blur.hidden=true;
        }
    }
    else
    {
        blur.hidden=true;
        btn.hidden=false;
        [btn setTitle:@"Rút gọn" forState:UIControlStateNormal];
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

+(float)heightWithShop:(Shop *)shop withMode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode
{
    float height=25;
    
    if(shop.descHeight.floatValue==-1)
        shop.descHeight=@([shop.desc sizeWithFont:FONT_SIZE_NORMAL(13) constrainedToSize:CGSizeMake(244, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=shop.descHeight.floatValue;
    
    if(mode==SHOP_DETAIL_INFO_DESCRIPTION_NORMAL)
        height=MIN(SHOP_DETAIL_INFO_DESC_HEIGHT_MAX_NORMAL,height);
    
    return height;
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
