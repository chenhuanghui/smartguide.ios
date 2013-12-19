//
//  SUUserCommentCell.h
//  SmartGuide
//
//  Created by MacMini on 05/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopUserCommentCell.h"
#import "CommentTyping.h"
#import "Shop.h"

@class TableUserComment;

@interface SUUserCommentCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet TableUserComment *table;
    __weak CommentTyping *cmtTyping;
    __weak UITapGestureRecognizer *_tapTable;
    __weak Shop* _shop;
}

-(void) loadWithShop:(Shop*) shop maxHeight:(float) maxHeight;
-(void) tableDidScrollWithContentOffSetY:(float) contentOffSetY cellContentY:(float) y;

+(NSString *)reuseIdentifier;
+(float) heightWithShop:(Shop*) shop;
+(float) tableY;

@end

@interface TableUserComment : UITableView

@end