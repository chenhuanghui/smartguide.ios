//
//  ShopDetailInfoToolCell.h
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoTypeBGView.h"
#import "ASIOperationShopDetailInfo.h"

@interface ShopDetailInfoType1Cell : UITableViewCell
{
    __weak IBOutlet UIButton *btnTick;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIImageView *line;
}

-(void) loadWithInfo1:(Info1*) info1;
-(void) setCellPos:(enum CELL_POSITION) cellPos;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end
