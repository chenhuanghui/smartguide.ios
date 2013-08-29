//
//  ShopComment.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ASIOperationShopComment.h"
#import "ASIOperationPostComment.h"
#import "ShopDetailViewController.h"
#import "TableTemplate.h"

@interface ShopComment : UIView<UITextFieldDelegate,ShopViewHandle,ASIOperationPostDelegate,TableTemplateDelegate>
{
    __weak IBOutlet UITableView *tableComments;
    __weak IBOutlet UITextField *txtComment;
    __weak IBOutlet UIImageView *avatar;
    __weak IBOutlet UIImageView *arrow;
    __weak IBOutlet UIView *containtAvatar;
    
    ASIOperationShopComment *_operationComment;
    TableTemplate *_templateComment;
    NSMutableArray *_comments;
    __weak IBOutlet UIView *containComment;
    __weak IBOutlet UIView *containInput;
    
    __weak Shop *_shop;
    int _page;
    bool _isShowedComment;
    bool _isPreparedShowBigComment;
    bool _isSendingComment;
    UITapGestureRecognizer *tapComment;
}

-(ShopComment*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

@end