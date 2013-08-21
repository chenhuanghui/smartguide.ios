#import "_Group.h"

@interface Group : _Group 
{
}

+(Group*) groupWithIDGroup:(int) idGroup;
+(Group*) groupAll;

-(NSString*) key;

-(NSString*) imageName;
-(bool) isActived;

-(UIImage*) iconPin;

@end