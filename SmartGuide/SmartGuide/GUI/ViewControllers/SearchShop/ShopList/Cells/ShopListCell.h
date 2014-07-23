//
//  ShopListCell.h
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ScrollListCell,ShopListCell, ShopList;

@protocol ShopListCellDelegate <NSObject>

-(void) shopListCellTouched:(ShopListCell*) cell shop:(ShopList*) shop;
-(void) shopListCellTouchedAdd:(ShopListCell*) cell shop:(ShopList*) shop;
-(void) shopListCellTouchedRemove:(ShopListCell*) cell shop:(ShopList*) shop;
-(bool) shopListCellCanSlide:(ShopListCell*) cell;

@end

@interface ShopListCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UIImageView *imgvVoucher;
    __weak IBOutlet UIImageView *imgvType;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UILabel *lblContent;
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
    __weak IBOutlet UIView *summaryView;
    __weak IBOutlet UIView *imgvLineBot;
    
    __weak ShopList *_shop;
    bool _didAddedObserver;
}

-(void) loadWithShopList:(ShopList*) shopList;
-(void) setButtonTypeIsTypeAdded:(bool) isTypeAdded;
-(ShopList*) shopList;
+(NSString *)reuseIdentifier;
+(float) addressHeight;
-(void) closeLove;

-(void) tableDidScroll:(UITableView*) table;

-(void) addObserver;
-(void) removeObserver;

@property (nonatomic, weak) id<ShopListCellDelegate> delegate;

@end

@interface ScrollListCell : UIScrollView<UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet ShopListCell *cell;

@end

@interface UITableView(ShopListCell)

-(void) registerShopListCell;
-(ShopListCell*) shopListCell;

@end