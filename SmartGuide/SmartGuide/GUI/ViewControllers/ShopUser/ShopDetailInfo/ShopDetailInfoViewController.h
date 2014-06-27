//
//  ShopDetailInfoViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ShopDetailInfoViewController, Shop;

@protocol ShopDetailInfoControllerDelegate <SGViewControllerDelegate>

-(void) shopDetailInfoControllerTouchedShop:(ShopDetailInfoViewController*) controller idShop:(int) idShop;

@end

@interface ShopDetailInfoViewController : SGViewController
{
    __weak IBOutlet UIImageView *imgvCover;
    __weak IBOutlet UIImageView *imgvBgCover;
    __weak IBOutlet UIView *coverView;
    __weak IBOutlet UITableView *table;
    
    CGRect _coverFrame;
    
    bool _didLoadShopDetail;
    float _heightDesc;
    
    __weak Shop* _shop;
    NSMutableArray *_infos;
}

-(ShopDetailInfoViewController*) initWithShop:(Shop*) shop;

@property (nonatomic, weak) id<ShopDetailInfoControllerDelegate> delegate;

@end