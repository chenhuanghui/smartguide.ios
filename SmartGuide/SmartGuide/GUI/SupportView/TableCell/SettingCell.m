//
//  SettingCell.m
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SettingCell.h"
#import "Utility.h"

@implementation SettingCell

-(void)setData:(SettingCellData *)data
{
    icon.image=data.icon;
    CGRect rect=icon.frame;
    rect.size=data.icon.size;
    icon.frame=rect;
    
    lblTitle.text=data.title;
}

+(NSString *)reuseIdentifier
{
    return @"SettingCell";
}

+(float)height
{
    return 32;
}

@end

@implementation SettingCellData
@synthesize title,child,icon;

@end