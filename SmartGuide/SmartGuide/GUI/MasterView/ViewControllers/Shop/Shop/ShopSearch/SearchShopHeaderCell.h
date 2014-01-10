//
//  SearchShopHeaderCell.h
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchShopHeaderCell : UITableViewCell
{
    __weak IBOutlet UILabel *lbl;
}

-(void) setHeaderText:(NSString*) text;

+(float) height;
+(NSString *)reuseIdentifier;

@end
