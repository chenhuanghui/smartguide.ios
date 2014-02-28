//
//  ShopPinInfoView.h
//  SmartGuide
//
//  Created by MacMini on 28/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopList.h"

@interface ShopPinInfoView : UIView
{
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblShopType;
    __weak IBOutlet UIButton *btnArrow;
    __weak IBOutlet UIView *cornerView;
    
    __weak ShopList *_shop;
}

-(void) setShop:(ShopList*) shop;
-(ShopList*) shop;

@end
