//
//  ShopUserGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum SHOP_USER_GALLERY_CELL_STATE {
    SHOP_USER_GALLERY_STATE_EMPTY = 1,
    SHOP_USER_GALLERY_STATE_THUMBNAIL=3
    };

@interface ShopUserGalleryCell : UIView
{
    __weak IBOutlet UIImageView *imgvThumbnail;
    __weak IBOutlet UIImageView *imgvState;
}

-(void) loadWithURL:(NSString*) url state:(enum SHOP_USER_GALLERY_CELL_STATE) state;

+(NSString *)reuseIdentifier;
+(CGSize) size;

@end
