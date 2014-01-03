//
//  ImageManager.h
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject

+(ImageManager*) sharedInstance;

@property (nonatomic, strong, readonly) NSMutableArray *shopLogos;
@property (nonatomic, strong, readonly) NSMutableArray *shopGallery;
@property (nonatomic, strong, readonly) NSMutableArray *shopUserGallery;
@property (nonatomic, strong, readonly) NSMutableArray *commentAvatar;
@property (nonatomic, strong, readonly) NSMutableArray *storeLogo;

@end

@interface UIImageView(ImageManager)

-(void) loadShopLogoWithURL:(NSString*) url;
-(void) loadShopGalleryWithURL:(NSString*) url;
-(void) loadShopUserGalleryWithURL:(NSString*) url;
-(void) loadCommentAvatarWithURL:(NSString*) url;
-(void) loadStoreLogoWithURL:(NSString*) url;
-(void) loadPlaceAuthorAvatarWithURL:(NSString*) url;
-(void) loadShopCoverWithURL:(NSString*) url;
-(void) loadImageInfo3WithURL:(NSString*) url;
-(void) loadImageHomeWithURL:(NSString*) url;
-(void) loadImageHomeListWithURL:(NSString*) url;
-(void) loadImagePromotionNewsWithURL:(NSString*) url;

@end