//
//  PlaceListInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "UserPlacelist.h"

@interface PlaceListInfoCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UIImageView *imgTick;
    __weak IBOutlet UILabel *lblNumOfShop;
    __weak IBOutlet UIImageView *lineBottom;
    
    __weak UserPlacelist *_place;
}

-(void) loadWithUserPlace:(UserPlacelist*) place;
-(void) setIsTicked:(bool) isTicked;
-(void) setCellPosition:(enum CELL_POSITION) cellPos;

-(UserPlacelist*) place;

+(NSString *)reuseIdentifier;
+(float) height;

@end
