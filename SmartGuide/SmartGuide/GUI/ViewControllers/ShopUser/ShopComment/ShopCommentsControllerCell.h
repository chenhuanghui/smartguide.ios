//
//  SUUserCommentCell.h
//  SmartGuide
//
//  Created by MacMini on 05/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ShopCommentsControllerCell,UserCommentBGMidView,HPGrowingTextView,Shop, ButtonAgree;

@protocol ShopCommentsControllerCellDelegate <NSObject>

-(void) shopCommentsControllerCellChangeSort:(ShopCommentsControllerCell*) cell sort:(enum SORT_SHOP_COMMENT) sort;
-(void) shopCommentsControllerCellUserComment:(ShopCommentsControllerCell*) cell comment:(NSString*) comment;

@end

@interface ShopCommentsControllerCell : UITableViewCell
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIView *touchView;
    __weak UITapGestureRecognizer *_tapTable;
    __weak IBOutlet UserCommentBGMidView *bgView;
    __weak IBOutlet HPGrowingTextView *txt;
    __weak IBOutlet UIImageView *typeCommentBot;
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UIView *containButtonView;
    __weak IBOutlet ButtonAgree *btnSort;
    __weak IBOutlet UIButton *btnShare;
    __weak IBOutlet ButtonAgree *btnSend;
    __weak IBOutlet UIView *animationView;
    enum SORT_SHOP_COMMENT _sort;
    bool _isAnimating;
    __weak Shop* _shop;
}

-(void) loadWithShop:(Shop*) shop sort:(enum SORT_SHOP_COMMENT) sort maxHeight:(float) height;
-(void) tableDidScroll:(UITableView*) tableUser cellRect:(CGRect) cellRect buttonNextHeight:(float) buttonHeight;

+(NSString *)reuseIdentifier;
+(float) heightWithShop:(Shop*) shop sort:(enum SORT_SHOP_COMMENT) sort;
+(float) tableY;
-(void) focus;
-(void) clearInput;
-(void) reloadData;

-(void) switchToNormailModeAnimate:(bool) animate duration:(float) duration;
-(void) switchToEditingModeAnimate:(bool) animate duration:(float) duration;

-(UITableView*) table;

@property (nonatomic, weak) id<ShopCommentsControllerCellDelegate> delegate;

@end

@interface UserCommentBGMidView : UIView

@end

@interface UITableView(ShopCommentsControllerCell)

-(void) registerShopCommentsControllerCell;
-(ShopCommentsControllerCell*) shopCommentsControllerCell;

@end