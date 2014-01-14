//
//  PlaceListInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceListInfoCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UIImageView *imgTick;
    __weak IBOutlet UILabel *lblNumOfShop;
}

-(void) loadWithNumOfShop:(NSString*) numOfShop name:(NSString*) name isTicked:(bool) isTicked;
-(void) setIsTicked:(bool) isTicked;

+(NSString *)reuseIdentifier;
+(float) height;

@end
