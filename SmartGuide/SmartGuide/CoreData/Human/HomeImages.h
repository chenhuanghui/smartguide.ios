#import "_HomeImages.h"

@interface HomeImages : _HomeImages 
{
}

+(HomeImages*) makeWithData:(NSDictionary*) dict;

@property (nonatomic, assign) CGSize homeImageSize;

@end
