//
//  PlacelistHeaderCell.h
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacelistHeaderCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblHeader;
    
}

-(void) setHeader:(NSString*) text;

+(NSString *)reuseIdentifier;
+(float) height;

@end