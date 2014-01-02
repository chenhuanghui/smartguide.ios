//
//  SearchShopCell.h
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"
#import "Placelist.h"

@interface SearchShopCell : UITableViewCell
{
    __weak IBOutlet UIView *bg;
    __weak IBOutlet FTCoreTextView *lbl;
    __weak IBOutlet UIImageView *icon;
    
    __weak NSDictionary *_dict;
    __weak Placelist *_place;
}

-(void) loadWithDataAutocomplete:(NSDictionary*) dict;
-(void) loadWithPlace:(Placelist*) place;

-(NSDictionary*) data;
-(Placelist*) place;

+(NSString *)reuseIdentifier;
+(float) height;

@end
