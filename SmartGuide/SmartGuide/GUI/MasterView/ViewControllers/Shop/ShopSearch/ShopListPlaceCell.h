//
//  ShopListPlaceCell.h
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Placelist.h"
#import "LabelTopText.h"

@interface ShopListPlaceCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvIcon;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblBy;
    __weak IBOutlet UILabel *lblAuthorName;
    __weak IBOutlet UILabel *lblNumOfView;
    __weak IBOutlet LabelTopText *lblContent;
    __weak IBOutlet UIImageView *imgvAuthorAvatar;
    
}

-(void) loadWithPlace:(Placelist*) place;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end
