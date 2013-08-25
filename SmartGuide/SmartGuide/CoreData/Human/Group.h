#import "_Group.h"

@interface Group : _Group 
{
}

+(Group*) groupWithIDGroup:(int) idGroup;
+(Group*) groupAll;
+(Group*) food;
+(Group*) drink;
+(Group*) health;
+(Group*) entertaiment;
+(Group*) fashion;
+(Group*) travel;
+(Group*) production;
+(Group*) education;

-(NSString*) key;

-(NSString*) imageName;
-(bool) isActived;

-(UIImage*) iconPin;

@end