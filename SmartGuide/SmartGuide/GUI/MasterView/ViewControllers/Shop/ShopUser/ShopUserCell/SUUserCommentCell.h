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
@class SUUserCommentCell;

@protocol UserCommentDelegate <NSObject>

-(bool) userCommentCanLoadMore:(SUUserCommentCell*) cell;
-(void) userCommentLoadMore:(SUUserCommentCell*) cell;
-(void) userCommentChangeSort:(SUUserCommentCell*) cell sort:(enum SORT_SHOP_COMMENT) sort;
-(void) userCommentUserComment:(SUUserCommentCell*) cell comment:(NSString*) comment isShareFacebook:(bool) isShare;

@end

@interface SUUserCommentCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate,CommentTypingDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet TableUserComment *table;
    __weak CommentTyping *cmtTyping;
    __weak UITapGestureRecognizer *_tapTable;
    
    NSArray *_comments;
}

-(void) loadWithComments:(NSArray*) comments sort:(enum SORT_SHOP_COMMENT) sort maxHeight:(float) height;
-(void) tableDidScroll:(UITableView*) tableUser cellRect:(CGRect) cellRect;

+(NSString *)reuseIdentifier;
+(float) heightWithComments:(NSArray*) comments maxHeight:(float) maxHeight;
+(float) tableY;
-(void) focus;

-(UITableView*) table;

@property (nonatomic, weak) id<UserCommentDelegate> delegate;

@end

@interface TableUserComment : UITableView

@end