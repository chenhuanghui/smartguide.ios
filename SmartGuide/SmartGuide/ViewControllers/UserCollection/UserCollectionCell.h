//
//  UserCollectionCell.h
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "CBAutoScrollLabel.h"

@interface UserCollectionCell : UITableViewCell
{
    __weak IBOutlet UIImageView *logo;
    __weak IBOutlet UILabel *lblSGP;
    __weak IBOutlet UILabel *lblSP;
    __weak IBOutlet UILabel *lblTime;
    __weak IBOutlet UILabel *lblDay;
    __weak IBOutlet CBAutoScrollLabel *lblName;
    
}

-(void) loadData:(Shop*) collection;

+(NSString *)reuseIdentifier;
+(CGSize) size;

@end
