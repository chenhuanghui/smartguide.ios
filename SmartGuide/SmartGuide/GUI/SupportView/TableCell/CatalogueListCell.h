//
//  CatalogueListCell.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"

@class Shop,CatalogueListCell;

@interface CatalogueListCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblKM;
    __weak IBOutlet FTCoreTextView *lblScore;
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIImageView *bg;
    __weak IBOutlet UIImageView *groupType;
    __weak IBOutlet UIImageView *imgVND;
}

+(NSString *)reuseIdentifier;

-(void) setData:(Shop*) data;
-(void) refreshData;

+(float) height;

@end