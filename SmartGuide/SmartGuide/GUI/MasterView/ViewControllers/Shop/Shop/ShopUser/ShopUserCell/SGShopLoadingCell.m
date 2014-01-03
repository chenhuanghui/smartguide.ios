//
//  SGShopEmptyCell.m
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGShopLoadingCell.h"

@implementation SGShopLoadingCell

+(float)height
{
    return 204;
}

+(NSString *)reuseIdentifier
{
    return @"SGShopLoadingCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    bgStatusView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_status.png"]];
}

@end
