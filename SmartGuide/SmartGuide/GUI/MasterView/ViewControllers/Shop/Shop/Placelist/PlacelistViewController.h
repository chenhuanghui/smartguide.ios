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

@protocol PlacelistControllerDelegate <SGViewControllerDelegate>

@end

@interface PlacelistViewController : SGViewController<UITableViewDelegate,UITableViewDataSource,ASIOperationPostDelegate>
{
    __weak ShopList *_shoplist;
    __weak IBOutlet UITableView *table;
    
    ASIOperationUserPlacelist *_operationUserPlacelist;
    int _page;
    bool _isLoadingMore;
    bool _isCanLoadMore;
    NSMutableArray *_placelists;
}

-(PlacelistViewController*) initWithShopList:(ShopList*) shoplist;

@property (nonatomic, weak) id<PlacelistControllerDelegate> delegate;

@end
