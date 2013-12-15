//
//  StoreShopItemCell.h
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreShop.h"

@interface StoreShopCell : UIView
{
    __weak IBOutlet UIImageView *imgvLineVer;
    __weak IBOutlet UIImageView *imgvHor1;
    __weak IBOutlet UIImageView *imgvHor2;
    __weak IBOutlet UIImageView *imgvCount;
    __weak IBOutlet UILabel *lblCount;
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblType;
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UIView *topRightView;
}

-(void) loadWithStore:(StoreShop*) store;
-(void) emptyCell:(bool) isEmpty;

+(NSString *)reuseIdentifier;
+(CGSize) smallSize;
+(CGSize) bigSize;

@end
