//
//  ImageManager.m
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ImageManager.h"

static ImageManager *_imageManager=nil;
@implementation ImageManager
@synthesize shopGallery,shopLogos,shopUserGallery,commentAvatar;

+(ImageManager*) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imageManager=[[ImageManager alloc] init];
    });
    
    return _imageManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        shopGallery=[NSMutableArray new];
        shopLogos=[NSMutableArray new];
        shopUserGallery=[NSMutableArray new];
        commentAvatar=[NSMutableArray new];
    }
    return self;
}

@end

@implementation UIImageView(ImageManager)

-(void) loadShopLogoWithURL:(NSString*) url
{
    
}

-(void) loadShopGalleryWithURL:(NSString*) url
{
    
}

-(void) loadShopUserGalleryWithURL:(NSString*) url
{
 
    
}

-(void) loadCommentAvatarWithURL:(NSString*) url
{
    
}

-(void)loadStoreLogoWithURL:(NSString *)url
{
    
}

-(void)loadPlaceAuthorAvatarWithURL:(NSString *)url
{
    
}

-(void)loadShopCoverWithURL:(NSString *)url
{
    
}

@end