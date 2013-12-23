//
//  ShopDetailInfoImageCell.h
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoTypeBGView.h"
#import "ASIOperationShopDetailInfo.h"

@interface ShopDetailInfoType3Cell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet InfoTypeBGView *bg;
}

-(void) loadWithInfo3:(Info3*) info3 isLastCell:(bool) isLastCell;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end
