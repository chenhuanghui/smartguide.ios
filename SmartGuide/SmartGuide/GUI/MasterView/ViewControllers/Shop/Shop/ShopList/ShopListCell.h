//
//  ShopListCell.h
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelTopText.h"
#import "ShopList.h"
#import "SGScrollView.h"
#import "ASIOperationLoveShop.h"

@class ScrollListCell,ShopListCell;

@protocol ShopListCellDelegate <NSObject>

-(void) shopListCellTouched:(ShopList*) shop;
-(void) shopListCellTouchedAdd:(ShopList*) shop;
-(void) shopListCellTouchedRemove:(ShopList*) shop;

@end

@interface ShopListCell : UITableViewCell<UIScrollViewDelegate>
{
    __weak IBOutlet UIImageView *imgvVoucher;
    __weak IBOutlet UIImageView *imgvType;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet LabelTopText *lblContent;
    __weak IBOutlet UILabel *lblAddress;
    __weak IBOutlet UIImageView *imgvLine;
    __weak IBOutlet UIButton *btnLove;
    __weak IBOutlet ScrollListCell *scroll;
    __weak IBOutlet UIImageView *imgvHeartAni;
    __weak IBOutlet UIView *leftView;
    __weak IBOutlet UIView *rightView;
    __weak IBOutlet UIButton *btnAddRemove;
    
    __weak ShopList *_shop;
}

-(void) loadWithShopList:(ShopList*) shopList;
-(void) setButtonTypeIsTypeAdded:(bool) isTypeAdded;
-(ShopList*) shopList;
+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@property (nonatomic, weak) id<ShopListCellDelegate> delegate;

@end

@interface ScrollListCell : SGScrollView<UIGestureRecognizerDelegate>

@end