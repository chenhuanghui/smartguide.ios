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

-(bool) isDefaultUser;

-(NSString *) accessToken;

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

-(enum USER_DATA_MODE) enumDataMode;

@end
