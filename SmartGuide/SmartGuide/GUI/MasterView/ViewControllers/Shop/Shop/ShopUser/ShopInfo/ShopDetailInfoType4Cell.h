//
//  ShopDetailInfoType4Cell.h
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelTopText.h"
#import "InfoTypeBGView.h"
#import "ASIOperationShopDetailInfo.h"

@interface ShopDetailInfoType4Cell : UITableViewCell
{
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblDate;
    __weak IBOutlet LabelTopText *lblContent;
    __weak IBOutlet UIImageView *line;
}

-(void) loadWithInfo4:(Info4*) info4;
-(void)setCellPos:(enum CELL_POSITION)cellPos;

+(float) heightWithContent:(NSString*) content;
+(NSString *)reuseIdentifier;

@end
