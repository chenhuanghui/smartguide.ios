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
#import "Constant.h"

@implementation BannerAdsCell

-(void)setURL:(NSString *)urlStr page:(int) page completed:(void (^)())onCompleted
{
    lblPage.text=[NSString stringWithFormat:@"%02i",page];
    
    imgv.image=nil;
    [imgv setSmartGuideImageWithURL:[NSURL URLWithString:urlStr] placeHolderImage:UIIMAGE_LOADING_SHOP_COVER success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        imgv.image=image;
        onCompleted();
    } failure:nil];
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
