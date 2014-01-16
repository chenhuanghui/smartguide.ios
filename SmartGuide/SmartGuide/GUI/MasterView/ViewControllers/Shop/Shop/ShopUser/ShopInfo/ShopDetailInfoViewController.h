//
//  ShopDetailInfoViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ASIOperationShopDetailInfo.h"
#import "Shop.h"
#import "ShopList.h"
#import "ShopDetailInfoCell.h"
#import "ShopDetailInfoEmptyCell.h"
#import "ShopDetailInfoType1Cell.h"
#import "ShopDetailInfoType2Cell.h"
#import "ShopDetailInfoType3Cell.h"
#import "ShopDetailInfoType4Cell.h"
#import "ShopDetailInfoHeaderView.h"
#import "ShopDetailInfoDescCell.h"

@class ShopDetailInfoScrollView;

@interface ShopDetailInfoViewController : SGViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UIImageView *imgvCover;
    __weak IBOutlet UIImageView *imgvBgCover;
    __weak IBOutlet UIView *coverView;
    __weak IBOutlet UITableView *table;
    
    CGRect _coverFrame;
    
    ASIOperationShopDetailInfo *_operation;
    bool _didLoadShopDetail;
    enum SHOP_DETAIL_INFO_DESCRIPTION_MODE _descMode;
    float _heightDesc;
    
    __weak Shop* _shop;
//    __weak ShopList *_shopList;
    NSMutableArray *_infos;
}

-(ShopDetailInfoViewController*) initWithShop:(Shop*) shop;
//-(ShopDetailInfoViewController*) initWithShopList:(ShopList*) shopList;

@end