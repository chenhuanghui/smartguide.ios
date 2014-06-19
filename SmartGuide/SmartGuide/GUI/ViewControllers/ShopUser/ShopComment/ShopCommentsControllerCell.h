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

@interface ShopCommentsControllerCell : UICollectionViewCell
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
    __weak IBOutlet ButtonAgree *btnSend;
    __weak IBOutlet UIView *animationView;
    bool _isAnimating;
    __weak Shop* _shop;
    bool _isEditing;
}

-(void) loadWithShop:(Shop*) shop maxHeight:(float) height;
-(void) tableDidScroll:(UICollectionView*) tableUser;

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

@interface UICollectionView(ShopCommentsControllerCell)

-(void) registerShopCommentsControllerCell;
-(ShopCommentsControllerCell*) shopCommentsControllerCellForIndexPath:(NSIndexPath*) indexPath;

@end