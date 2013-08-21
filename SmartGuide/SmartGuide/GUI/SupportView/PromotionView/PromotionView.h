//
//  PromotionView.h
//  SmartGuide
//
//  Created by XXX on 7/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import "Shop.h"

@interface PromotionView : UIView<GMGridViewActionDelegate,GMGridViewDataSource>
{
    __weak IBOutlet UILabel *lblCurrentPoint;
    __weak IBOutlet UILabel *lblPoint;
    __weak IBOutlet GMGridView *gridReward;
    
    __weak Shop *_shop;
}

-(PromotionView*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

@end