//
//  HomeImageType9Cell.m
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeImageType9Cell.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation HomeImageType9Cell

-(void)loadWithURL:(NSString *)url size:(CGSize)size
{
    [imgv loadImageHome9WithURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"HomeImageType9Cell";
}

@end
