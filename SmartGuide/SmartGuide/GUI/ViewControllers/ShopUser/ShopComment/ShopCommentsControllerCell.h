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

enum SHOP_COMMENT_MODE
{
    SHOP_COMMENT_MODE_NORMAL=0,
    SHOP_COMMENT_MODE_EDIT=1
};

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
    __weak IBOutlet ButtonAgree *btnSend;
    __weak IBOutlet UIView *animationView;
    __weak IBOutlet UIView *containView;
    __weak IBOutlet UIView *containComments;
    __weak IBOutlet UIImageView *imgvFirstComment;
    bool _isAnimating;
    __weak Shop* _shop;
    bool _isEditing;
}

-(void) loadWithShop:(Shop*) shop maxHeight:(float) height;
-(void) tableDidScroll:(UITableView*) tableUser;

+(NSString *)reuseIdentifier;
+(float) heightWithShop:(Shop*) shop sort:(enum SORT_SHOP_COMMENT) sort;
+(float) tableY;
-(void) focus;
-(void) clearInput;
-(void) reloadData;

-(void) switchToMode:(enum SHOP_COMMENT_MODE) mode animate:(bool) animate duration:(float) duration;

-(UITableView*) table;

@property (nonatomic, weak) id<ShopCommentsControllerCellDelegate> delegate;

@end

@interface UserCommentBGMidView : UIView

@end

@interface UITableView(ShopCommentsControllerCell)

-(void) registerShopCommentsControllerCell;
-(ShopCommentsControllerCell*) shopCommentsControllerCell;

@end