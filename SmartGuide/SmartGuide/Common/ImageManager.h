//
//  ImageManager.h
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SDWebImageManager.h"

@interface ImageManager : NSObject

+(ImageManager*) sharedInstance;

-(NSArray*) loadingImages;
-(NSArray*) loadingMoreImages;

@property (nonatomic, strong, readonly) NSMutableArray *shopLogos;
@property (nonatomic, strong, readonly) NSMutableArray *shopGallery;
@property (nonatomic, strong, readonly) NSMutableArray *shopUserGallery;
@property (nonatomic, strong, readonly) NSMutableArray *commentAvatar;
@property (nonatomic, strong, readonly) NSMutableArray *storeLogo;

@end

@interface UIImageView(ImageManager)

-(void) loadAvatarWithURL:(NSString*) url;
-(void) loadAvatarWithURL:(NSString*) url completed:(SDWebImageCompletedBlock)completedBlock;
-(void) loadShopLogoWithURL:(NSString*) url;
-(void) loadShopGalleryWithURL:(NSString*) url;
-(void) loadShopUserGalleryWithURL:(NSString*) url;
-(void) loadShopUserGalleryThumbnailWithURL:(NSString*) url;
-(void) loadCommentAvatarWithURL:(NSString*) url;
-(void) loadStoreLogoWithURL:(NSString*) url;
-(void) loadPlaceAuthorAvatarWithURL:(NSString*) url;
-(void) loadShopCoverWithURL:(NSString*) url;
-(void) loadImageInfo3WithURL:(NSString*) url;
-(void) loadShopLogoPromotionHome:(NSString*) url completed:(SDWebImageCompletedBlock) completedBlock;
-(void) loadImageHomeWithURL:(NSString*) url;
-(void) loadImageHomeListWithURL:(NSString*) url;
-(void) loadImagePromotionNewsWithURL:(NSString*) url;

@end

@interface UIButton(ImageManager)

-(void) loadImage:(NSString*) url;
-(void) loadImage:(NSString*) url onCompleted:(void(^)(UIImage *image)) onCompleted;

@end