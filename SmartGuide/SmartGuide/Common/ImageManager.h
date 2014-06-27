//
//  ImageManager.h
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWebImageManager.h"
#import "Constant.h"

@class ImageDefaultBackgroundView;

@interface ImageManager : NSObject

+(ImageManager*) sharedInstance;

-(NSArray*) loadingImages;
-(NSArray*) loadingMoreImages;
-(NSArray*) loadingImagesSmall;
-(UIImage*) shopPinWithType:(enum SHOP_TYPE) shopType;
-(UIImage*) shopImageTypeWithType:(enum SHOP_TYPE) shopType;

@property (nonatomic, strong, readonly) NSMutableArray *shopLogos;
@property (nonatomic, strong, readonly) NSMutableArray *shopGallery;
@property (nonatomic, strong, readonly) NSMutableArray *shopUserGallery;
@property (nonatomic, strong, readonly) NSMutableArray *commentAvatar;
@property (nonatomic, strong, readonly) NSMutableArray *storeLogo;
@property (nonatomic, strong, readonly) NSMutableDictionary *imageScaleCrop;

@end

@interface UIImageView(ImageManager)

-(void) loadAvatarWithURL:(NSString*) url;
-(void) loadAvatarWithURL:(NSString*) url completed:(SDWebImageCompletedBlock) completedBlock;
-(void) loadShopLogoWithURL:(NSString*) url;
-(void) loadShopGalleryWithURL:(NSString*) url;
-(void) loadGalleryFullWithURL:(NSString *)url;
-(void) loadShopUserGalleryWithURL:(NSString*) url;
-(void) loadShopUserGalleryThumbnailWithURL:(NSString*) url size:(CGSize) size;
-(void) loadCommentAvatarWithURL:(NSString*) url size:(CGSize) size;
-(void) loadPlaceAuthorAvatarWithURL:(NSString*) url;
-(void) loadShopCoverWithURL:(NSString*) url;
-(void) loadShopCoverWithURL:(NSString*) url resize:(CGSize) size;
-(void) loadImageInfo3WithURL:(NSString*) url;
-(void) loadShopLogoPromotionHome:(NSString*) url completed:(SDWebImageCompletedBlock) completedBlock;
-(void) loadShopLogoPromotionHome:(NSString*) url;
-(void) loadImageHomeWithURL:(NSString*) url;
-(void) loadImageHomeListWithURL:(NSString*) url;
-(void) loadImageHomeListWithURL:(NSString*) url completed:(SDWebImageCompletedBlock) completedBlock;
-(void) loadImagePromotionNewsWithURL:(NSString*) url size:(CGSize) size;
-(void) loadHome6CoverWithURL:(NSString*) url;
-(void) loadHome7CoverWithURL:(NSString*) url;
-(void) loadUserPromotionCoverWithURL:(NSString*) url;
-(void) loadUserNotificationContentWithURL:(NSString*) url;
-(void) loadVideoThumbnailWithURL:(NSString*) url;
-(void) loadGalleryThumbnailWithURL:(NSString*) url resize:(CGSize) size;

-(void) showLoadingImageSmall;
-(void) stopLoadingImageSmall;
-(void) showDefaultBackground;
-(void) removeDefaultBackground;

@property (nonatomic, readwrite, weak) UIImageView *loadingSmall;
@property (nonatomic, readwrite, weak) ImageDefaultBackgroundView *defaultBackground;

@end

@interface UIButton(ImageManager)

-(void) loadImage:(NSString*) url;
-(void) loadImage:(NSString*) url onCompleted:(void(^)(UIImage *image)) onCompleted;

@end

@interface ImageDefaultBackgroundView : UIView

@end