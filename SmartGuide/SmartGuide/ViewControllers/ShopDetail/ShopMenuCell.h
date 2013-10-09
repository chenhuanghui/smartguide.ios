//
//  ShopMenuCell.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopMenuCell : UITableViewCell
{
    __weak IBOutlet UITextView *lblName;
    __weak IBOutlet UILabel *lblPrice;
    
}

-(void) setName:(NSString*) name setPrice:(NSString*) price;
+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end
