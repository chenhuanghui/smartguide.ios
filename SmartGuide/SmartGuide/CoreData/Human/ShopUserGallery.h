#import "_ShopUserGallery.h"

@interface ShopUserGallery : _ShopUserGallery 
{
}

+(ShopUserGallery*) makeWithJSON:(NSDictionary*) data;

@property (nonatomic, strong) UIImage *imagePosed;

@end
