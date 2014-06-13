//
//  ShopUserCommentCell.h
//  SmartGuide
//
//  Created by MacMini on 22/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ShopUserComment,ButtonAgree;

@interface ShopUserCommentCell : UITableViewCell
{
    __weak IBOutlet UIImageView *lineBot;
    __weak IBOutlet UIImageView *lineTop;
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UILabel *lblUsername;
    __weak IBOutlet UILabel *lblComment;
    __weak IBOutlet UILabel *lblTime;
    __weak IBOutlet UILabel *lblNumOfAgree;
    __weak IBOutlet UIButton *btnAgree;
    
    __weak ShopUserComment *_comment;
}

-(void) loadWithComment:(ShopUserComment*) comment;
-(void) setCellPosition:(enum CELL_POSITION) cellPos;

+(NSString *)reuseIdentifier;
+(float) heightWithComment:(ShopUserComment*) comment;

@end

@interface UITableView(ShopUserCommentCell)

-(void) registerShopUserCommentCell;
-(ShopUserCommentCell*) shopUserCommentCell;

@end