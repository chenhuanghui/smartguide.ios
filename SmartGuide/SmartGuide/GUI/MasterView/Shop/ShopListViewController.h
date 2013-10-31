//
//  ShopListViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Constant.h"
#import "SGTableTemplate.h"
#import "CatalogueListCell.h"
#import "ASIOperationShopInGroup.h"
#import "ShopUserViewController.h"

@protocol ShopListDelegate <NSObject>

-(void) shopListSelectedShop;

@end

@interface ShopListViewController : SGViewController<SGTableTemplateDelegate,ASIOperationPostDelegate,ShopUserDelegate>
{
    __weak IBOutlet UITableView *tableList;
    __weak IBOutlet UIView *blurrTop;
    __weak IBOutlet UIView *blurrBot;
    SGTableTemplate *templateShopList;
    
    void(^_onFinishedLoadCatalog)(bool isSuccessed);
    
    ASIOperationShopInGroup *_operationShopList;
}

-(void) loadWithCatalog:(ShopCatalog*) catalog onCompleted:(void(^)(bool isSuccessed)) onFinishedLoadCatalog;

@property (nonatomic, assign) id<ShopListDelegate> delegate;
@property (nonatomic, strong) NSString *catalog;

@end
