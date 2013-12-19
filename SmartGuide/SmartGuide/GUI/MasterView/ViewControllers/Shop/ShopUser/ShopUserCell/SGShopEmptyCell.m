//
//  SGShopEmptyCell.m
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGShopEmptyCell.h"

@implementation SGShopEmptyCell

+(float)height
{
    return 204;
}

+(NSString *)reuseIdentifier
{
    return @"SGShopEmptyCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    bgStatusView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_status.png"]];
}

@end
