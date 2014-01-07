//
//  AvatarCell.m
//  SmartGuide
//
//  Created by MacMini on 06/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AvatarCell.h"
#import "Utility.h"

@implementation AvatarCell

-(void)loadWithURL:(NSString *)url
{
    _url=[url copy];
}

-(NSString *)url
{
    return _url;
}

+(NSString *)reuseIdentifier
{
    return @"AvatarCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_CELL);
    self.frame=rect;
}

@end
