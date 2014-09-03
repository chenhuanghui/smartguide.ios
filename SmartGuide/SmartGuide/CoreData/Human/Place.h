#import "_Place.h"

@interface Place : _Place 
{
}

+(Place*) makeWithData:(NSDictionary*) dict;

@property (nonatomic, assign) CGRect descRect;
@property (nonatomic, assign) CGRect nameRect;

@end
