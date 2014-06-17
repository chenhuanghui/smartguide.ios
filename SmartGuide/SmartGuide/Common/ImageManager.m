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
    [self showLoadingImageSmall];
    
    __weak UIImageView* wSelf=self;
    [self setImageWithURL:URL(url) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
            [wSelf stopLoadingImageSmall];
    }];
}

-(void) loadShopGalleryWithURL:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:IPHONE_IMAGE_DOWNLOAD_OPTIONS];
}

-(void)loadGalleryFullWithURL:(NSString *)url
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
            [wSelf showDefaultBackground];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
            [wSelf removeDefaultBackground];
    }];
}

-(void) loadShopUserGalleryWithURL:(NSString*) url
{
    [self showLoadingImageSmall];
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wself)
            [wself stopLoadingImageSmall];
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
    [self loadImageWithDefaultLoading:url];
}

-(void)loadShopCoverWithURL:(NSString *)url resize:(CGSize)size
{
    __weak UIImageView *wSelf=self;
    [self loadImageWithDefaultLoading:url resize:^UIImage *(UIImage *downloadImage) {
        if(wSelf)
            return resizeProportionalImage(downloadImage,size);
        
        return nil;
    } willSize:size];
}

-(void)loadImageInfo3WithURL:(NSString *)url
{
    [self showLoadingImageSmall];
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wself)
            [wself stopLoadingImageSmall];
    }];
}

-(void)loadImageHomeWithURL:(NSString *)url
{
    [self showLoadingImageSmall];
    __weak UIImageView *wself=self;
    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [wself stopLoadingImageSmall];
    }];
}

-(void) loadShopLogoPromotionHome:(NSString*) url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void)loadShopLogoPromotionHome:(NSString *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:URL(url) completed:completedBlock];
}

-(void)loadImageHomeListWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:IPHONE_IMAGE_DOWNLOAD_OPTIONS];
}

-(void)loadImageHomeListWithURL:(NSString *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:IPHONE_IMAGE_DOWNLOAD_OPTIONS completed:completedBlock];
}

-(void)loadImagePromotionNewsWithURL:(NSString *)url size:(CGSize)size
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
            [wSelf showLoadingImageSmall];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
            [wSelf stopLoadingImageSmall];
    } resize:^UIImage *(UIImage *downloadImage) {
        if(wSelf)
            return resizeProportionalImage(downloadImage, size);
        
        return nil;
    } willSize:size];
}

-(void)loadAvatarWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url]];
}

-(void)loadAvatarWithURL:(NSString *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:[NSURL URLWithString:url] completed:completedBlock];
}

-(void)loadShopUserGalleryThumbnailWithURL:(NSString *)url size:(CGSize)size
{
    [self showLoadingImageSmall];
    
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
            [wSelf showLoadingImageSmall];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
            [wSelf stopLoadingImageSmall];
    } resize:^UIImage *(UIImage *downloadImage) {
        if(wSelf)
            return resizeProportionalImage(downloadImage, size);
        
        return nil;
    } willSize:size];
}

-(void)loadImageScaleCrop:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
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

-(void)loadUserNotificationContentWithURL:(NSString *)url
{
    [self setImageWithURL:URL(url)];
}

-(void)loadVideoThumbnailWithURL:(NSString *)url
{
    [self setImageWithURL:URL(url)];
}

-(void)loadGalleryThumbnailWithURL:(NSString *)url resize:(CGSize)size
{
    __weak UIImageView *wSelf=self;
    
    [self loadImageWithDefaultLoading:url resize:^UIImage *(UIImage *downloadImage) {
        
        NSLog(@"resize gallery thumbnail %@ %@",url,NSStringFromCGSize(size));
        
        if(wSelf)
            return resizeProportionalImage(downloadImage, size);
        
        return nil;
    } willSize:size];
}

-(void) showLoadingImageSmall
{
    if(self.loadingSmall)
        return;
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:rect];
    imgv.autoresizingMask=UIViewAutoresizingDefault();
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

-(void) loadImageWithDefaultLoading:(NSString*) url
{
    __weak UIImageView *wSelf=self;
    
    [self setImageWithURL:URL(url) onDownload:^{
        if(wSelf)
            [wSelf showLoadingImageSmall];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(wSelf)
            [wSelf stopLoadingImageSmall];
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