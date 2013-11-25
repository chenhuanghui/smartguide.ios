//
//  ShopUserCommentCell.h
//  SmartGuide
//
//  Created by MacMini on 22/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopUserCommentCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UILabel *lblUsername;
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblComment;
    __weak IBOutlet UILabel *lblTime;
    __weak IBOutlet UIView *borderView;
}

-(void) loadWithComment:(NSString*) comment;

+(NSString *)reuseIdentifier;
+(float) heightSummary;
+(float) heightWithComment:(NSString*) comment;

@end
