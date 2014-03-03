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
static NSMutableArray *_loadingImagesSmall=nil;
static NSMutableArray *_loadingMoreImages=nil;

#define trackImageScaleMode //if(URL(url))[[ImageManager sharedInstance].imageScaleCrop setObject:[NSValue valueWithCGSize:self.l_v_s] forKey:URL(url)];

@interface ImageManager()<SDWebImageManagerDelegate>

@end

static ImageManager *_imageManager=nil;
@implementation ImageManager
@synthesize shopGallery,shopLogos,shopUserGallery,commentAvatar,storeLogo,imageScaleCrop;

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
        imageScaleCrop=[NSMutableDictionary new];

        [SDWebImageManager sharedManager].delegate=self;
    }
    
    return self;
}

-(UIImage *)imageManager1:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL
{
    NSLog(@"%@ %@",imageURL,imageScaleCrop[imageURL]);
    
    if(imageURL && image)
    {
        NSValue *value=imageScaleCrop[imageURL];

        if(value)
        {
            float screenScale=UIScreenScale();
            CGSize size=[value CGSizeValue];
            image=[image scaleProportionalToSize:CGSizeMake(size.width*screenScale, size.height*screenScale)];
            if(image.scale!=screenScale)
                return [UIImage imageWithCGImage:image.CGImage scale:screenScale orientation:image.imageOrientation];
        }
    }
    
    return image;
}

-(NSArray *)loadingImages
{
    if(!_loadingImages)
    {
        _loadingImages=[NSMutableArray new];
        for(int i=0;i<=14;i++)
        {
            [_loadingImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"button_loading_big_%02i.png",i]]];
        }
    }
    
    return _loadingImages;
}

-(NSArray *)loadingImagesSmall
{
    if(!_loadingImagesSmall)
    {
        _loadingImagesSmall=[NSMutableArray new];
        for(int i=0;i<=11;i++)
        {
            [_loadingImagesSmall addObject:[UIImage imageNamed:[NSString stringWithFormat:@"button_loading_small_%02i.png",i]]];
        }
    }
    
    return _loadingImagesSmall;
}

-(NSArray *)loadingMoreImages
{
    return _loadingMoreImages;
}

-(UIImage *)shopPinWithType:(enum SHOP_TYPE)shopType
{
    switch (shopType) {
        case SHOP_TYPE_TRAVEL:
            return [UIImage imageNamed:@"iconpin_travel.png"];
            
        case SHOP_TYPE_PRODUCTION:
            return [UIImage imageNamed:@"iconpin_shopping.png"];
            
        case SHOP_TYPE_HEALTH:
            return [UIImage imageNamed:@"iconpin_healness.png"];
            
        case SHOP_TYPE_FOOD:
            return [UIImage imageNamed:@"iconpin_food.png"];
            
        case SHOP_TYPE_FASHION:
            return [UIImage imageNamed:@"iconpin_fashion.png"];
            
        case SHOP_TYPE_ENTERTAIMENT:
            return [UIImage imageNamed:@"iconpin_entertaiment.png"];
            
        case SHOP_TYPE_EDUCATION:
            return [UIImage imageNamed:@"iconpin_education.png"];
            
        case SHOP_TYPE_CAFE:
            return [UIImage imageNamed:@"iconpin_drink.png"];
            
        case SHOP_TYPE_ALL:
            return nil;
    }
}

-(UIImage *)shopImageTypeWithType:(enum SHOP_TYPE)shopType
{
    switch (shopType) {
        case SHOP_TYPE_ALL:
            return nil;
            
        case SHOP_TYPE_CAFE:
            return [UIImage imageNamed:@"icon_drink.png"];
            
        case SHOP_TYPE_EDUCATION:
            return [UIImage imageNamed:@"icon_education.png"];
            
        case SHOP_TYPE_ENTERTAIMENT:
            return [UIImage imageNamed:@"icon_entertaiment.png"];
            
        case SHOP_TYPE_FASHION:
            return [UIImage imageNamed:@"icon_fashion.png"];
            
        case SHOP_TYPE_FOOD:
            return [UIImage imageNamed:@"icon_food.png"];
            
        case SHOP_TYPE_HEALTH:
            return [UIImage imageNamed:@"icon_healness.png"];
            
        case SHOP_TYPE_PRODUCTION:
            return [UIImage imageNamed:@"icon_shopping.png"];
            
        case SHOP_TYPE_TRAVEL:
            return [UIImage imageNamed:@"icon_travel.png"];
    }
}

@end

@implementation UIImageView(ImageManager)

-(void) loadShopLogoWithURL:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void) loadShopGalleryWithURL:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageProgressiveDownload];
}

-(void) loadShopUserGalleryWithURL:(NSString*) url
{
    UIViewContentMode mode=[self showLoadingImageSmall];
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [wself stopLoadingImageSmall:mode];
    }];
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
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageProgressiveDownload];
}

-(void)loadImageInfo3WithURL:(NSString *)url
{
    UIViewContentMode mode=[self showLoadingImageSmall];
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [wself stopLoadingImageSmall:mode];
    }];
}

-(void)loadImageHomeWithURL:(NSString *)url
{
    [[ImageManager sharedInstance].imageScaleCrop setObject:[NSValue valueWithCGSize:self.l_v_s] forKey:URL(url)];
    
    UIViewContentMode mode=[self showLoadingImageSmall];
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [wself stopLoadingImageSmall:mode];
    }];
}

-(void) loadShopLogoPromotionHome:(NSString*) url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:[NSURL URLWithString:url]  completed:completedBlock];
}

-(void)loadImageHomeListWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageProgressiveDownload];
}

-(void)loadImagePromotionNewsWithURL:(NSString *)url
{
    UIViewContentMode mode=[self showLoadingImageSmall];
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [wself stopLoadingImageSmall:mode];
    }];
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
    trackImageScaleMode
    UIViewContentMode mode=[self showLoadingImageSmall];
    
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *_image, NSError *error, SDImageCacheType cacheType) {
        [wself stopLoadingImageSmall:mode];
    }];
}

-(void)loadImageScaleCrop:(NSString *)url
{
    trackImageScaleMode
    
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageProgressiveDownload];
}

-(void) loadHome6CoverWithURL:(NSString*) url
{
    [self loadImageScaleCrop:url];
}

-(void) loadHome7CoverWithURL:(NSString*) url
{
    [self loadImageScaleCrop:url];
}

-(void) loadUserPromotionCoverWithURL:(NSString*) url
{
    [self loadImageScaleCrop:url];
}

-(UIViewContentMode) showLoadingImage
{
    self.animationImages=[ImageManager sharedInstance].loadingImages;
    self.animationDuration=0.7f;
    self.animationRepeatCount=0;
    
    UIViewContentMode mode=self.contentMode;
    self.contentMode=UIViewContentModeCenter;
    [self startAnimating];
    
    return mode;
}

-(void) stopLoadingImage:(UIViewContentMode) mode
{
    self.animationImages=nil;
    [self stopAnimating];
    self.contentMode=mode;
}

-(UIViewContentMode) showLoadingImageSmall
{
    if(self.isAnimating)
        return self.contentMode;
    
    self.animationImages=[ImageManager sharedInstance].loadingImagesSmall;
    self.animationDuration=0.7f;
    self.animationRepeatCount=0;
    
    UIViewContentMode mode=self.contentMode;
    
    if(self.l_v_w<39 || self.l_v_h<14)
        self.contentMode=UIViewContentModeScaleToFill;
    else
        self.contentMode=UIViewContentModeCenter;
    
    [self startAnimating];
    
    return mode;
}

-(void) stopLoadingImageSmall:(UIViewContentMode) mode
{
    self.animationImages=nil;
    [self stopAnimating];
    self.contentMode=mode;
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