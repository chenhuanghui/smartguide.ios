//
//  ShopCommentCell.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopUserComment.h"

@interface ShopCommentCell : UITableViewCell
{
    __weak IBOutlet UIImageView *avatar;
    __weak IBOutlet UILabel *name;
    __weak IBOutlet UILabel *comment;
    __weak IBOutlet UILabel *time;
    __weak IBOutlet UILabel *lblShopName;
}

-(void) setShopComment:(ShopUserComment*) userComment widthChanged:(float) changedWidth isZoomed:(bool) isZoomed;
+(float) heightWithContent:(NSString*) content widthChanged:(float) changedWidth isZoomed:(bool) isZoomed;
+(NSString *)reuseIdentifier;

@end
