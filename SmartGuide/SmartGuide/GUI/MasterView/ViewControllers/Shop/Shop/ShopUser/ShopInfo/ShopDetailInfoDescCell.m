//
//  ShopDetailInfoDescCell.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopDetailInfoDescCell.h"

@implementation ShopDetailInfoDescCell
@synthesize delegate;

-(void)loadWithContent:(NSString *)content mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode
{
    _mode=mode;
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

+(float)heightWithContent:(NSString *)content withMode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode
{
    return 25;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoDescCell";
}

@end
