//
//  SGShopEmptyCell.h
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGShopLoadingCell : UITableViewCell
{
    __weak IBOutlet UIView *bgStatusView;
}

+(float) height;
+(NSString *)reuseIdentifier;

@end
