//
//  ShopKM1Cel.h
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopKM1Cell : UITableViewCell
{
    __weak IBOutlet UILabel *ll;
    
}

-(void) setLL:(NSString*) text;

+(NSString *)reuseIdentifier;
+(float) height;

@end
