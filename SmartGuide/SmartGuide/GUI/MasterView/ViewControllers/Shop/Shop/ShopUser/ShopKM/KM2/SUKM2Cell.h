//
//  SUKM2Cell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopKM2.h"

@interface SUKM2Cell : UITableViewCell

-(void) loadWithKM2:(ShopKM2*) km2;

+(NSString *)reuseIdentifier;
+(float) heightWithKM2:(ShopKM2*) km2;

@end
