//
//  SearchShopPlacelistCell.h
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelTopText.h"
#import "Placelist.h"

@interface SearchShopPlacelistCell : UITableViewCell
{
    __weak IBOutlet UIImageView *icon;
    __weak IBOutlet LabelTopText *lblTitle;
    __weak IBOutlet LabelTopText *lblContent;
    __weak IBOutlet UIImageView *line;
}

-(void) loadWithPlace:(Placelist*) place;
-(void) setIsLastCell:(bool) isLastCell;

+(float) heightWithPlace:(Placelist*) place;
+(NSString *)reuseIdentifier;

@end
