//
//  ShopDetailInfoToolCell.h
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailInfoToolCell : UITableViewCell
{
    __weak IBOutlet UIButton *btnTick;
    __weak IBOutlet UILabel *lblContent;
}

-(void) loadWithContent:(NSString*) content withState:(bool) isTicked;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end
