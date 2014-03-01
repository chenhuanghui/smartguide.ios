#import "_UserGalleryUpload.h"

enum USER_GALLERY_UPLOAD_STATUS {
    USER_GALLERY_UPLOAD_STATUS_LISTED = 0,
    USER_GALLERY_UPLOAD_STATUS_NEXT = 1,
    };

@class UserGalleryUpload;

@protocol UserGalleryUploadDelegate <NSObject>

-(void) userGalleryUploadDidChangeStatus:(UserGalleryUpload*) upload;

@end

@interface UserGalleryUpload : _UserGalleryUpload 
{
}

+(void) clearUserGalleryUpLoad;
+(UserGalleryUpload*) makeWithIDShop:(int) idShop image:(UIImage*) image;

-(enum USER_GALLERY_UPLOAD_STATUS) enumStatus;

@property (nonatomic, strong) id objConnection;
@property (nonatomic, weak) id<UserGalleryUploadDelegate> delegate;

@end
