//
//  PopupGiftPromotion2.h
//  SmartGuide
//
//  Created by MacMini on 10/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionVoucher.h"

@class PopupGiftPromotion2;

@protocol PopupGiftPromotionDelegate <NSObject>

-(void) popupGiftDidSelectedVoucher:(PopupGiftPromotion2*) popup voucher:(PromotionVoucher*) voucher;
-(void) popupGiftDidCancelled:(PopupGiftPromotion2*) popup;

@end

@interface PopupGiftPromotion2 : UIView<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIView *blurView;
    __weak IBOutlet UIImageView *imgv;
    
    NSMutableArray *_vouchers;
}

-(PopupGiftPromotion2*) initWithVouchers:(NSArray*) vouchesr delegate:(id<PopupGiftPromotionDelegate>) delegate;

@property (nonatomic, assign) id<PopupGiftPromotionDelegate> delegate;

@end
