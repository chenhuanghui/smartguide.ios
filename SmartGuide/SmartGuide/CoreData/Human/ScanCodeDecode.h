#import "_ScanCodeDecode.h"

enum SCANCODE_DECODE_TYPE
{
    SCANCODE_DECODE_TYPE_UNKNOW=0,
    SCANCODE_DECODE_TYPE_HEADER=1,
    SCANCODE_DECODE_TYPE_BIGTEXT=2,
    SCANCODE_DECODE_TYPE_SMALLTEXT=3,
    SCANCODE_DECODE_TYPE_IMAGE=4,
    SCANCODE_DECODE_TYPE_VIDEO=5,
    SCANCODE_DECODE_TYPE_BUTTONS=6,
    SCANCODE_DECODE_TYPE_SHARE=7,
};

@interface ScanCodeDecode : _ScanCodeDecode 
{
}

+(ScanCodeDecode*) makeWithDictionary:(NSDictionary*) dict;

-(enum SCANCODE_DECODE_TYPE) enumType;

@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGSize videoSize;
@property (nonatomic, assign) CGRect textRect;

@end
