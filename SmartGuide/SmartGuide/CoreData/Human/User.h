#import "_User.h"
#import <MapKit/MapKit.h>

@interface User : _User<MKAnnotation>
{
}

+(User*) userWithPhone:(NSString*) phone;
+(User*) userWithIDUser:(int) idUser;
-(enum SORT_BY) currentSort;

@property (nonatomic, assign) int idCity;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) CLLocationCoordinate2D location;

@end
