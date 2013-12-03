//
//  ShopDetailInfoDetailCell.h
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailInfoDetailCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblLeft;
    __weak IBOutlet UILabel *lblRight;
}

-(void) loadWithName:(NSString*) name withContent:(NSString*) content;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end
