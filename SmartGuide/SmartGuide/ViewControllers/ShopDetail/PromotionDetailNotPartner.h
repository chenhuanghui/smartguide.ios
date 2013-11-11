//
//  PromotionDetailNotPartner.h
//  SmartGuide
//
//  Created by MacMini on 11/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ShopDetailViewController.h"

@interface PromotionDetailNotPartner : UIView<PromotionDetailHandle,UITableViewDataSource,UITableViewDelegate>
{
    __weak Shop *_shop;
    __weak IBOutlet UILabel *lblDuration;
    __weak IBOutlet UITableView *tablePromotion;
}

-(PromotionDetailNotPartner*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

@end
