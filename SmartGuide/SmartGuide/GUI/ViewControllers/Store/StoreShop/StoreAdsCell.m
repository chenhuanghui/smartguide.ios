//
//  StoreTopAdsCell.m
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreAdsCell.h"
#import "Utility.h"

@implementation StoreAdsCell

+(NSString *)reuseIdentifier
{
    return @"StoreAdsCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
}

@end
