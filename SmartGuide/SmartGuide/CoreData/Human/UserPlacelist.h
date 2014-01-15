#import "_UserPlacelist.h"

@interface UserPlacelist : _UserPlacelist 
{
}

+(UserPlacelist*) userPlacelistWithIDPlacelist:(int) idPlace;
+(UserPlacelist*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, readonly) NSArray *arrayIDShops;

@end
