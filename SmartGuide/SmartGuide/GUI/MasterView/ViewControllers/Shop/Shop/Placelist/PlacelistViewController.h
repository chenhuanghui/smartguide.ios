//
//  PlacelistViewController.h
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ShopList.h"
#import "ASIOperationUserPlacelist.h"
#import "ASIOperationCreatePlacelist.h"

@protocol PlacelistControllerDelegate <SGViewControllerDelegate>

@end

@interface PlacelistViewController : SGViewController<UITableViewDelegate,UITableViewDataSource,ASIOperationPostDelegate>
{
    __weak ShopList *_shoplist;
    __weak IBOutlet UITableView *table;
    
    CGRect _tableFrame;
    
    ASIOperationCreatePlacelist *_operationCreatePlacelist;
    
    ASIOperationUserPlacelist *_operationUserPlacelist;
    int _page;
    bool _isLoadingMore;
    bool _isCanLoadMore;
    NSMutableArray *_placelists;
    bool _isLoadingPlacelist;
}

-(PlacelistViewController*) initWithShopList:(ShopList*) shoplist;

@property (nonatomic, weak) id<PlacelistControllerDelegate> delegate;

@end
