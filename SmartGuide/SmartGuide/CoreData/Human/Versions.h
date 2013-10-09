#import "_Versions.h"

@interface Versions : _Versions 
{
}

+(NSString*) versionWithType:(int) type;
+(void) setVersion:(int) type version:(NSString*) version;

@end
