//
//  ShopUserGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserGalleryCell.h"
#import "Utility.h"
#import "ImageManager.h"
#import "UIImageView+WebCache.h"

@implementation ShopUserGalleryCell

-(void)loadWithURL:(NSString *)url state:(enum SHOP_USER_GALLERY_CELL_STATE)state
{
    switch (state) {
        case SHOP_USER_GALLERY_STATE_ARROW_LEFT:
            
            [imgvThumbnail loadShopUserGalleryThumbnailWithURL:url];
            imgvState.image=[UIImage imageNamed:@"icon_arrowleft_photo.png"];
            
            break;
            
        case SHOP_USER_GALLERY_STATE_ARROW_RIGHT:
            
            [imgvThumbnail loadShopUserGalleryThumbnailWithURL:url];
            imgvState.image=[UIImage imageNamed:@"icon_arrowright_photo.png"];
            
            break;
            
        case SHOP_USER_GALLERY_STATE_THUMBNAIL:
        {
            [imgvThumbnail loadShopUserGalleryThumbnailWithURL:url];
            imgvState.image=nil;
        }
            
            break;
            
        case SHOP_USER_GALLERY_STATE_EMPTY:
            
            imgvThumbnail.image=nil;
            imgvState.image=[UIImage imageNamed:@"icon_picture_photo.png"];
            
            break;
    }
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
