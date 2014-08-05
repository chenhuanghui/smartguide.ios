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
    [self loadImageWithURL:url];
}

-(void)loadGalleryFullWithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void) loadCommentAvatarWithURL:(NSString*) url size:(CGSize)size
{
    [self loadImageWithURL:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void)loadPlaceAuthorAvatarWithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void)loadShopCoverWithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void)loadShopCoverWithURL:(NSString *)url onCompleted:(SDWebImageCompletedBlock)completedBlock size:(CGSize)size
{
    [self loadImageWithURL:url onCompleted:completedBlock resize:^UIImage *(UIImage *image) {
        return resizeProportionalImage(image, size);
    } willSize:size allowDefaultBackground:false];
}

-(void)loadShopCoverWithURL:(NSString *)url resize:(CGSize)size
{
    [self loadImageWithURL:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void)loadImageInfo3WithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void)loadImageHomeWithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void)loadImageHome9WithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void) loadHomeHeaderWithURL:(NSString *)url
{
    [self loadImageWithURL:url allowDefaultBackground:true];
}

-(void) loadShopLogoPromotionHome:(NSString*) url
{
    [self loadImageWithURL:url];
}

-(void)loadShopLogoPromotionHome:(NSString *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self loadImageWithURL:url onCompleted:completedBlock];
}

-(void)loadImageHomeListWithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void)loadImagePromotionNewsWithURL:(NSString *)url size:(CGSize)size
{
    [self loadImageWithURL:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void)loadAvatarWithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void)loadAvatarWithURL:(NSString *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self loadImageWithURL:url onCompleted:completedBlock];
}

-(void)loadShopUserGalleryThumbnailWithURL:(NSString *)url size:(CGSize)size
{
    [self loadImageWithURL:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void) loadHome6CoverWithURL:(NSString*) url
{
    [self loadImageWithURL:url];
}

-(void) loadUserPromotionCoverWithURL:(NSString*) url
{
    [self loadImageWithURL:url];
}

-(void)loadUserNotificationContentWithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void)loadVideoThumbnailWithURL:(NSString *)url
{
    [self loadImageWithURL:url];
}

-(void)loadGalleryThumbnailWithURL:(NSString *)url resize:(CGSize)size
{
    [self loadImageWithURL:url resize:^UIImage *(UIImage *downloadImage) {
        return resizeProportionalImage(downloadImage, size);
    } willSize:size];
}

-(void) loadScanImageWithURL:(NSString*) url
{
    [self loadImageWithURL:url];
}

-(void) loadScanVideoThumbnailWithURL:(NSString*) url
{
    [self loadImageWithURL:url];
}

-(void) loadScanRelatedImageWithURL:(NSString*) url
{
    [self loadImageWithURL:url];
}

-(void) showLoadingImageSmall
{
    if(self.loadingSmall)
    {
        [self.loadingSmall startAnimating];
        return;
    }
    
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

-(void) removeLoadingImageSmall
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

-(void) loadImageWithURL:(NSString*) url
{
    [self loadImageWithURL:url allowDefaultBackground:false];
}

-(void) loadImageWithURL:(NSString*) url allowDefaultBackground:(bool) allowDefaultBackground
{
    [self loadImageWithURL:url onCompleted:nil resize:nil willSize:CGSizeZero allowDefaultBackground:allowDefaultBackground];
}

-(void) loadImageWithURL:(NSString*) url onCompleted:(SDWebImageCompletedBlock) completedBlock
{
    [self loadImageWithURL:url onCompleted:completedBlock resize:nil willSize:CGSizeZero allowDefaultBackground:false];
}

-(void) loadImageWithURL:(NSString*) url resize:(UIImage*(^)(UIImage* image)) resizeMethod willSize:(CGSize) willSize
{
    [self loadImageWithURL:url onCompleted:nil resize:resizeMethod willSize:willSize allowDefaultBackground:false];
}

-(void) loadImageWithURL:(NSString*) url onCompleted:(SDWebImageCompletedBlock) completedBlock resize:(UIImage*(^)(UIImage* image)) resizeMethod willSize:(CGSize) willSize allowDefaultBackground:(bool) allowDefaultBackground
{
    if(url.length==0)
    {
        self.image=nil;
        [self showDefaultBackground];
        return;
    }
    
    __weak UIImageView *wSelf=self;
    __block bool isCompleted=false;
    
    if(!allowDefaultBackground)
        [self removeDefaultBackground];
    else
        [self showDefaultBackground];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(wSelf && !isCompleted)
        {
            [wSelf showLoadingImageSmall];
        }
    });
    
    wSelf.image=nil;
    wSelf.alpha=1;
    
    [self setImageWithURL:URL(url) options:0 start:^(bool isFromWeb) {
        if(wSelf && (isFromWeb || !CGSizeEqualToSize(willSize, CGSizeZero)))
            [wSelf showLoadingImageSmall];
    } process:nil resize:resizeMethod willSize:willSize completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        isCompleted=true;
        
        if(wSelf)
        {
            wSelf.image=nil;
            wSelf.alpha=1;
            
            if(image)
            {
                [wSelf removeLoadingImageSmall];
                [wSelf removeDefaultBackground];
                
                wSelf.alpha=0;
                wSelf.image=image;
                
                [UIView animateWithDuration:0.3f animations:^{
                    wSelf.alpha=1;
                }];
            }
            else if(error)
            {
                [wSelf removeLoadingImageSmall];
                [wSelf showDefaultBackground];
            }
            else // opearation cancelled
            {
                [wSelf removeDefaultBackground];
                [wSelf showLoadingImageSmall];
            }
            
            if(completedBlock)
                completedBlock(image,error,cacheType);
        }
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