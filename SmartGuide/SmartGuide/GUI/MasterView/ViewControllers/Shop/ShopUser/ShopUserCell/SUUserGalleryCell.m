//
//  SUUserGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUUserGalleryCell.h"

@implementation SUUserGalleryCell
@synthesize delegate;

+(NSString *)reuseIdentifier
{
    return @"SUUserGalleryCell";
}

+(float)height
{
    return 190;
}

-(IBAction) btnMakePictureTouchUpInside:(id)sender
{
    [self.delegate userGalleryTouchedMakePicture:self];
}

@end
