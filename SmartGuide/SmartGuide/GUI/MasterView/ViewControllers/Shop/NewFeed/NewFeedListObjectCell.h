//
//  NewFeedListObjectCell.h
//  SmartGuide
//
//  Created by MacMini on 25/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeedListObjectCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UILabel *lblNumOfShop;
    __weak IBOutlet UILabel *lblTitle;
}

-(void) setImage:(NSString*) url title:(NSString*) title numOfShop:(NSString*) numOfShop content:(NSString*) content;
+(NSString *)reuseIdentifier;

@end
