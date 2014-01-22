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

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:[ShopUserGalleryCell reuseIdentifier] owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(void)loadWithURL:(NSString *)url state:(enum SHOP_USER_GALLERY_CELL_STATE)state
{
    switch (state) {
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

+(CGSize)size
{
    return CGSizeMake(92, 92);
}

@end
