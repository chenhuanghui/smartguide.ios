#import "_UserHome8.h"
#import "Shop.h"

@interface UserHome8 : _UserHome8 
{
}

+(UserHome8*) makeWithDictionary:(NSDictionary*) dict;

-(NSNumber*) idShop;
-(NSNumber*) shopType;
-(NSString*) shopTypeDisplay;
//-(NSString *)shopName;
-(NSNumber*) loveStatus;
-(NSString*) numOfLove;
-(NSString*) numOfView;
-(NSString*) numOfComment;
-(NSString*) logo;
-(NSString*) cover;
-(NSString*) coverFull;

@end
