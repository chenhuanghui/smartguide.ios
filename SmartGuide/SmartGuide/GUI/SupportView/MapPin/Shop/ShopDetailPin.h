//
//  ShopDetailPin.h
//  SmartGuide
//
//  Created by XXX on 8/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"

@interface ShopDetailPin : UIView
{
    __weak IBOutlet CBAutoScrollLabel *lblShopName;
    
}

-(ShopDetailPin*) initWithName:(NSString*) name;
-(void) setName:(NSString*) name;

@end
