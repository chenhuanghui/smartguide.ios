//
//  BannerAdsCell.m
//  SmartGuide
//
//  Created by XXX on 8/14/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "BannerAdsCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utility.h"

@implementation BannerAdsCell

-(void)setURL:(NSString *)urlStr page:(int) page completed:(void (^)())onCompleted
{
    lblPage.text=[NSString stringWithFormat:@"%02i",page];
    
    imgv.image=nil;
    [imgv setImageWithURL:[NSURL URLWithString:urlStr] onCompleted:^(id image) {
        
        if([image isKindOfClass:[UIImage class]])
            imgv.image=image;
        
        onCompleted();
    }];
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*2));
    
    return self;
}

+(NSString *)reuseIdentifier
{
    return @"BannerAdsCell";
}

+(CGSize)size
{
    return CGSizeMake(267, 74);
}

@end
