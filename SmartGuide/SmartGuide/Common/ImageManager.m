//
//  ImageManager.m
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ImageManager.h"
#import "UIImageView+WebCache.h"
#import "Utility.h"

static NSMutableArray *_loadingImages=nil;
static NSMutableArray *_loadingMoreImages=nil;

static ImageManager *_imageManager=nil;
@implementation ImageManager
@synthesize shopGallery,shopLogos,shopUserGallery,commentAvatar,storeLogo;

+(void)load
{
}

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

-(NSArray *)loadingImages
{
    if(!_loadingImages)
    {
        _loadingImages=[NSMutableArray new];
        for(int i=0;i<=11;i++)
        {
            [_loadingImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"button_loading_small_%02i",i]]];
        }
    }
    
    return _loadingImages;
}

-(NSArray *)loadingMoreImages
{
    return _loadingMoreImages;
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

-(void)loadImageHomeWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void) loadShopLogoPromotionHome:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_avashop_home.png"]];
}

-(void)loadImageHomeListWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageProgressiveDownload progress:nil completed:nil];
}

-(void)loadImagePromotionNewsWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void)loadAvatarWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void)loadAvatarWithURL:(NSString *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:[NSURL URLWithString:url] completed:completedBlock];
}

-(void)loadShopUserGalleryThumbnailWithURL:(NSString *)url
{
    self.animationImages=[ImageManager sharedInstance].loadingImages;
    self.animationDuration=0.7f;
    self.animationRepeatCount=0;
    
    UIViewContentMode mode=self.contentMode;
    self.contentMode=UIViewContentModeCenter;
    [self startAnimating];
    
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *_image, NSError *error, SDImageCacheType cacheType) {
        wself.animationImages=nil;
        [wself stopAnimating];
        wself.contentMode=mode;
    }];
}

@end

@implementation UIButton(ImageManager)

-(void)loadImage:(NSString *)url
{
    [self loadImage:url onCompleted:nil];
}

-(void)loadImage:(NSString *)url onCompleted:(void (^)(UIImage *))onCompleted
{
    __weak UIButton *wSelf=self;
    
    __block void(^_onCompleted)(UIImage* image)=nil;
    if(onCompleted)
        _onCompleted=[onCompleted copy];
    
    [self.imageView setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(image && wSelf)
        {
            [wSelf setDefaultImage:image highlightImage:image];
        }
        
        if(_onCompleted)
        {
            if(error)
                _onCompleted(nil);
            else
                _onCompleted(image);
            
            _onCompleted=nil;
        }
    }];
}

@end