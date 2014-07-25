#import "_UserHome8.h"

@interface UserHome8 : _UserHome8 
{
}

+(UserHome8*) makeWithDictionary:(NSDictionary*) dict;

-(NSNumber*) shopType;
-(NSString*) shopTypeDisplay;
-(NSNumber*) loveStatus;
-(NSString*) numOfLove;
-(NSString*) numOfView;
-(NSString*) numOfComment;
-(NSString*) logo;
-(NSString*) cover;
-(NSString*) coverFull;

@end
