//
//  HomeImageType9Cell.m
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeImageType9Cell.h"
#import "ImageManager.h"
#import "Utility.h"

@implementation HomeImageType9Cell

-(void)loadWithURL:(NSString *)url width:(float)width height:(float)height
{
    imgv.viewWillSize=CGSizeMake(self.home.home9Size.height, self.home.home9Size.width);
    
    [imgv loadImageHomeListWithURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"HomeImageType9Cell";
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width=self.home.home9Size.height;
    [super setFrame:frame];
}

-(void)awakeFromNib
{   
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
}

@end
