//
//  SettingCell.h
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDGroupCell.h"

@class SettingCellData;

@interface SettingCell : SDGroupCell
{
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIImageView *icon;
    __weak IBOutlet UITableView *table;
}

-(void) setData:(SettingCellData*) data;

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface SettingCellData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSArray *child;

@end