//
//  StoreShopInfoViewController.h
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class StoreShopInfoScrollView,StoreShopInfoViewController;

@interface StoreShopInfoViewController : SGViewController
{
    __weak IBOutlet StoreShopInfoScrollView *scroll;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UITableView *table;
}

@end

@interface StoreShopInfoScrollView : UIScrollView

@end