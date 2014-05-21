//
//  CityTableViewCell.h
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class CityObject;

@interface CityTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIImageView *imgvTop;
    __weak IBOutlet UIImageView *imgvBot;
    __weak IBOutlet UIImageView *imgvIcon;
    
    __weak CityObject *_obj;
}

-(void) loadWithCityObject:(CityObject*) obj marked:(bool) marked cellPos:(enum CELL_POSITION) cellPos;
-(CityObject*) cityObject;

+(NSString *)reuseIdentifier;
+(float) heightWithCityObject:(CityObject*) obj;

@end
