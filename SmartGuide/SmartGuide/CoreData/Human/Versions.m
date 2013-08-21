#import "Versions.h"

@implementation Versions

+(NSString *)versionWithType:(int)type
{
    Versions *version=[Versions queryVersionsObject:[NSPredicate predicateWithFormat:@"%K == %i",Versions_VersionType,type]];
    
    if(version)
        return version.version;
    
    return @"";
}

+(void)setVersion:(int)type version:(NSString *)version
{
    Versions *versions=[Versions queryVersionsObject:[NSPredicate predicateWithFormat:@"%K == %i",Versions_VersionType,type]];
    if(!versions)
    {
        versions=[Versions insert];
        versions.versionType=[NSNumber numberWithInt:type];
    }
    
    versions.version=version;
}

@end