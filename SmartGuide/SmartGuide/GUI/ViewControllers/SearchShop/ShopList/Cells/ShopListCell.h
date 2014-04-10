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
#import "ASIOperationLoveShop.h"
#import "ShopListViewController.h"

@class ScrollListCell,ShopListCell;

@protocol ShopListCellDelegate <NSObject>

-(void) shopListCellTouched:(ShopListCell*) cell shop:(ShopList*) shop;
-(void) shopListCellTouchedAdd:(ShopListCell*) cell shop:(ShopList*) shop;
-(void) shopListCellTouchedRemove:(ShopListCell*) cell shop:(ShopList*) shop;

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
    __weak IBOutlet UIButton *btnNumOfView;
    __weak IBOutlet UIButton *btnNumOfLove;
    __weak IBOutlet UIButton *btnNumOfComment;
    __weak IBOutlet UILabel *lblKM;
    
    __weak ShopList *_shop;
    ASIOperationLoveShop *_operationLove;
    bool _didAddedObsLove;
}

-(void) loadWithShopList:(ShopList*) shopList;
-(void) setButtonTypeIsTypeAdded:(bool) isTypeAdded;
-(ShopList*) shopList;
+(NSString *)reuseIdentifier;
+(float)heightWithShopList:(ShopList*) shop;
+(float) addressHeight;
-(void) closeLove;

-(void) tableDidScroll;

-(void) addObserverLove;
-(void) removeObserverLove;

@property (nonatomic, weak) id<ShopListCellDelegate> delegate;
@property (nonatomic, weak) TableShopList *table;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) ShopListViewController *controller;

@end

@interface ScrollListCell : UIScrollView<UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet ShopListCell *cell;

@end