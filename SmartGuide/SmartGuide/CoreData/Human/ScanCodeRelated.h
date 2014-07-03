#import "_ScanCodeRelated.h"

enum SCANCODE_RELATED_TYPE
{
    SCANCODE_RELATED_TYPE_UNKNOW=0,
    SCANCODE_RELATED_TYPE_SHOPS=1,
    SCANCODE_RELATED_TYPE_PLACELISTS=2,
    SCANCODE_RELATED_TYPE_PROMOTIONS=3,
};

@interface ScanCodeRelated : _ScanCodeRelated 
{
}

+(ScanCodeRelated*) makeWithDictionary:(NSDictionary*) dict;

-(enum SCANCODE_RELATED_TYPE) enumType;

@end
