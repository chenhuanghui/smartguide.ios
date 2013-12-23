//
//  ShopDetailInfoDetailCell.h
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIOperationShopDetailInfo.h"
#import "InfoTypeBGView.h"

@interface ShopDetailInfoType2Cell : UITableViewCell
{
    __weak IBOutlet UILabel *lblLeft;
    __weak IBOutlet UILabel *lblRight;
    __weak IBOutlet InfoTypeBGView *bg;
}

-(void) loadWithInfo2:(Info2*) info2 isLastCell:(bool) isLastCell;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end