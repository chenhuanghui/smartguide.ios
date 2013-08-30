//
//  GalleryCell.m
//  SmartGuide
//
//  Created by XXX on 8/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GalleryCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utility.h"
#import "Constant.h"

@implementation GalleryCell

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"GalleryCell") owner:nil options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void) setImageURL:(NSURL*) url
{
    imgv.image=nil;
    [imgv setImageWithLoading:url emptyImage:UIIMAGE_LOADING_SHOP_GALLERY success:^(UIImage *image) {
        [self setIMG:image];
    } failure:^(UIImage *emptyImage) {
        [self setIMG:emptyImage];
    }];
}

-(void)setIMG:(UIImage *)image
{
    imgv.image=nil;
    
    if(![image isKindOfClass:[UIImage class]])
        return;

    imgv.image=image;
}

+(NSString *)reuseIdentifier
{
    return @"GalleryCell";
}

-(UIImageView *)imgv
{
    return imgv;
}

+(CGSize)size
{
    return CGSizeMake(320, SCREEN_HEIGHT);
}

@end
