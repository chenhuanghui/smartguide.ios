//
//  PromotionDetailCell.h
//  SmartGuide
//
//  Created by XXX on 8/1/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionDetailCell : UITableViewCell
{
    __weak IBOutlet UIImageView *bar;
    __weak IBOutlet UILabel *lblSgp;
    __weak IBOutlet UILabel *lblContent;
}

-(void) setSGP:(int) sgp content:(NSString*) content hightlighted:(bool) isHightlighted;

+(NSString *)reuseIdentifier;
+(float) height;

@end
