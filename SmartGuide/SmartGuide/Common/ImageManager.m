//
//  ImageManager.m
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ImageManager.h"
#import "UIImageView+WebCache.h"

static ImageManager *_imageManager=nil;
@implementation ImageManager
@synthesize shopGallery,shopLogos,shopUserGallery,commentAvatar,storeLogo;

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
        storeLogo=[NSMutableArray new];
    }
    return self;
}

@end

@implementation UIImageView(ImageManager)

-(void) loadShopLogoWithURL:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void) loadShopGalleryWithURL:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void) loadShopUserGalleryWithURL:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void) loadCommentAvatarWithURL:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void)loadStoreLogoWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void)loadPlaceAuthorAvatarWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void)loadShopCoverWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void)loadImageInfo3WithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

@end