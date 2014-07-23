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
#import <objc/runtime.h>
#import "SDWebImageManager.h"

UIImage* resizeProportionalImage(UIImage* downloadImage, CGSize size)
{
    downloadImage=[downloadImage scaleProportionalToSize:CGSizeMake(size.width*UIScreenScale(), size.height*UIScreenScale())];
    if(downloadImage.scale!=UIScreenScale())
        downloadImage=[UIImage imageWithCGImage:downloadImage.CGImage scale:UIScreenScale() orientation:downloadImage.imageOrientation];
    
    return downloadImage;
}


#define IPHONE_IMAGE_DOWNLOAD_OPTIONS (IS_IPHONE_4?0:0)

static NSMutableArray *_loadingImages=nil;
static NSMutableArray *_loadingImagesSmall=nil;
static NSMutableArray *_loadingMoreImages=nil;

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

static char ImageViewLoadingSmallKey;
static char ImageViewDefaultBackgroundKey;
@implementation UIImageView(ImageManager)

-(ImageDefaultBackgroundView *)defaultBackground
{
    return objc_getAssociatedObject(self, &ImageViewDefaultBackgroundKey);
}

-(void)setDefaultBackground:(ImageDefaultBackgroundView *)defaultBackground_
{
    objc_setAssociatedObject(self, &ImageViewDefaultBackgroundKey, defaultBackground_, OBJC_ASSOCIATION_ASSIGN);
}

-(UIImageView *)loadingSmall
{
    return objc_getAssociatedObject(self, &ImageViewLoadingSmallKey);
}

-(void)setLoadingSmall:(UIImageView *)loadingSmall_
{
    objc_setAssociatedObject(self, &ImageViewLoadingSmallKey, loadingSmall_, OBJC_ASSOCIATION_ASSIGN);
}

-(void) loadShopLogoWithURL:(NSString*) url
{
    [self loadImageWithDefaultLoading:url];
}

-(void)loadGalleryFullWithURL:(NSString *)url
{
    [self loadImageWithDefaultLoading:url];
}

-(void) loadCommentAvatarWithURL:(NSString*) url size:(CGSize)size
{
    [self loadImageWithDefaultLoading:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void)loadPlaceAuthorAvatarWithURL:(NSString *)url
{
    [self loadImageWithDefaultLoading:url];
}

-(void)loadShopCoverWithURL:(NSString *)url
{
    [self loadImageWithDefaultLoading:url];
}

-(void)loadShopCoverWithURL:(NSString *)url resize:(CGSize)size
{
    [self loadImageWithDefaultLoadingAndBackground:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void)loadImageInfo3WithURL:(NSString *)url
{
    [self loadImageWithDefaultLoading:url];
}

-(void)loadImageHomeWithURL:(NSString *)url
{
    [self loadImageWithDefaultLoadingAndBackground:url];
}

-(void)loadImageHome9WithURL:(NSString *)url
{
    [self loadImageWithDefaultLoading:url];
}

-(void) loadShopLogoPromotionHome:(NSString*) url
{
    [self loadImageWithDefaultLoadingAndBackground:[NSURL URLWithString:url]];
}

-(void)loadShopLogoPromotionHome:(NSString *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self loadImageWithDefaultLoading:url onCompleted:completedBlock];
}

-(void)loadImageHomeListWithURL:(NSString *)url
{
    [self loadImageWithDefaultLoadingAndBackground:url];
}

-(void)loadImagePromotionNewsWithURL:(NSString *)url size:(CGSize)size
{
    [self loadImageWithDefaultLoading:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void)loadAvatarWithURL:(NSString *)url
{
    [self loadImageWithDefaultLoading:url];
}

-(void)loadAvatarWithURL:(NSString *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self loadImageWithDefaultLoading:url onCompleted:completedBlock];
}

-(void)loadShopUserGalleryThumbnailWithURL:(NSString *)url size:(CGSize)size
{
    [self loadImageWithDefaultLoading:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void) loadHome6CoverWithURL:(NSString*) url
{
    [self loadImageWithDefaultLoadingAndBackground:url];
}

-(void) loadUserPromotionCoverWithURL:(NSString*) url
{
    [self loadImageWithDefaultLoadingAndBackground:url];
}

-(void)loadUserNotificationContentWithURL:(NSString *)url
{
    [self loadImageWithDefaultLoading:url];
}

-(void)loadVideoThumbnailWithURL:(NSString *)url
{
    [self loadImageWithDefaultLoading:url];
}

-(void)loadGalleryThumbnailWithURL:(NSString *)url resize:(CGSize)size
{
    [self loadImageWithDefaultLoading:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void) loadScanImageWithURL:(NSString*) url
{
    [self loadImageWithDefaultLoading:url];
}

-(void) loadScanVideoThumbnailWithURL:(NSString*) url
{
    [self loadImageWithDefaultLoading:url];
}

-(void) loadScanRelatedImageWithURL:(NSString*) url
{
    [self loadImageWithDefaultLoading:url];
}

-(void) showLoadingImageSmall
{
    if(self.loadingSmall)
        return;
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:rect];
    imgv.autoresizingMask=UIViewAutoresizingDefault();
    
    CGSize loadingSize=CGSizeMake(39, 14);
    if(rect.size.width<loadingSize.width || rect.size.height<loadingSize.height)
        imgv.contentMode=UIViewContentModeScaleAspectFit;
    else
        imgv.contentMode=UIViewContentModeCenter;
    
    imgv.animationImages=[ImageManager sharedInstance].loadingImagesSmall;
    imgv.animationDuration=0.7f;
    imgv.animationRepeatCount=0;
    
    [imgv startAnimating];
    
    [self addSubview:imgv];
    
    self.loadingSmall=imgv;
}

-(void) stopLoadingImageSmall
{
    if(self.loadingSmall)
    {
        [self.loadingSmall stopAnimating];
        [self.loadingSmall removeFromSuperview];
        self.loadingSmall=nil;
    }
}

-(void) showDefaultBackground
{
    if(self.defaultBackground)
        return;
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    ImageDefaultBackgroundView *bg=[[ImageDefaultBackgroundView alloc] initWithFrame:rect];
    bg.autoresizingMask=UIViewAutoresizingDefault();
    
    bg.alpha=0;
    [self addSubview:bg];
    [self sendSubviewToBack:bg];

    __weak UIImageView *wSelf=self;
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        if(wSelf)
            bg.alpha=1;
    }];
    
    self.defaultBackground=bg;
}

-(void) removeDefaultBackground
{
    if(self.defaultBackground)
    {
        __weak UIImageView *wSelf=self;
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            if(wSelf)
                wSelf.defaultBackground.alpha=0;
        } completion:^(BOOL finished) {
            
            if(wSelf)
            {
                [wSelf.defaultBackground removeFromSuperview];
                wSelf.defaultBackground=nil;
            }
        }];
    }
}

-(void) loadImageWithDefaultBackground:(NSString*) url
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
            [wSelf showDefaultBackground];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf && image)
            [wSelf removeDefaultBackground];
    }];
}

-(void) loadImageWithDefaultLoading:(NSString*) url onCompleted:(SDWebImageCompletedBlock) completed
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
            [wSelf showLoadingImageSmall];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
        {
            [wSelf stopLoadingImageSmall];
            
            if(completed)
                completed(image,error,cacheType);
        }
    }];
}

-(void) loadImageWithDefaultLoading:(NSString*) url
{
    [self loadImageWithDefaultLoading:url onCompleted:nil];
}

-(void) loadImageWithDefaultLoadingAndBackground:(NSString*) url
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
        {
            [wSelf showDefaultBackground];
            [wSelf showLoadingImageSmall];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
        {
            [wSelf stopLoadingImageSmall];
            
            if(image)
                [wSelf removeDefaultBackground];
            else
                [wSelf showDefaultBackground];
        }
    }];
}

-(void) loadImageWithDefaultLoading:(NSString*) url resize:(UIImage*(^)(UIImage *downloadImage)) resize willSize:(CGSize) willSize
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
            [wSelf showLoadingImageSmall];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
            [wSelf stopLoadingImageSmall];
    } resize:^UIImage *(UIImage *downloadImage) {
        if(wSelf && resize)
            return resize(downloadImage);
        
        return nil;
    } willSize:willSize];
}

-(void) loadImageWithDefaultBackground:(NSString*) url resize:(UIImage*(^)(UIImage *downloadImage)) resize willSize:(CGSize) willSize
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
        {
            [wSelf showDefaultBackground];
            [wSelf showLoadingImageSmall];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
        {
            [wSelf stopLoadingImageSmall];
            
            if(image)
                [wSelf removeDefaultBackground];
            else
                [wSelf showDefaultBackground];
        }
    } resize:^UIImage *(UIImage *downloadImage) {
        if(wSelf && resize)
            return resize(downloadImage);
        
        return nil;
    } willSize:willSize];
}

-(void) loadImageWithDefaultLoadingAndBackground:(NSString*) url resize:(UIImage*(^)(UIImage *downloadImage)) resize willSize:(CGSize) willSize
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
        {
            [wSelf showDefaultBackground];
            [wSelf showLoadingImageSmall];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
        {
            [wSelf stopLoadingImageSmall];
            
            if(image)
                [wSelf removeDefaultBackground];
            else
                [wSelf showDefaultBackground];
        }
    } resize:^UIImage *(UIImage *downloadImage) {
        if(wSelf && resize)
            return resize(downloadImage);
        
        return nil;
    } willSize:willSize];
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

@implementation ImageDefaultBackgroundView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    [self setting];
    
    return self;
}

-(void) setting
{
    self.contentMode=UIViewContentModeRedraw;
    self.userInteractionEnabled=false;
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"pattern_image.jpg"] drawAsPatternInRect:rect];
}

@end