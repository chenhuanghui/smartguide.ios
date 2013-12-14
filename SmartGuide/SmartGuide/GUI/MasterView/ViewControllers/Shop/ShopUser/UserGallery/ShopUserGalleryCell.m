//
//  ShopUserGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserGalleryCell.h"
#import "Utility.h"

@implementation ShopUserGalleryCell

-(void) setLLB:(NSString*) text
{
    llb.text=text;
}

+(NSString*) reuseIdentifier
{
    return @"ShopUserGalleryCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    
    self.frame=rect;
}

+(float)height
{
    return 92;
}

@end
