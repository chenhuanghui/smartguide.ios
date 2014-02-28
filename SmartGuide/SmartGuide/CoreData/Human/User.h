#import "_User.h"
#import <MapKit/MapKit.h>

enum USER_DATA_MODE {
    USER_DATA_CREATING = 0, //user đã nhập activation code nhưng đến màn hình tạo/kết nối social thì ngưng
    USER_DATA_TRY = 1, //user mặc định
    USER_DATA_FULL = 2,
    };

@interface User : _User<MKAnnotation>
{
    CLLocationCoordinate2D _location;
}

+(User*) userWithIDUser:(int) idUser;
+(User*) makeWithDictionary:(NSDictionary*) dict;

-(bool) isDefaultUser;
-(enum GENDER_TYPE)enumGender;
-(enum SOCIAL_TYPE)enumSocialType;

-(NSString *) accessToken;

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

-(enum USER_DATA_MODE) enumDataMode;

-(UIImage*) avatarImage;
-(UIImage*) avatarBlurImage;

-(void) makeAvatarImage:(UIImage*) image;
-(UIImage*) makeAvatarBlurImage:(UIImage*) image isEffected:(bool) isEffected;

@end

@interface UIImageView(SupportLoadAvatar)

-(void) loadUserAvatar:(User*) user onCompleted:(void(^)(UIImage *avatar, UIImage *avatarBlurr)) completed;

@end