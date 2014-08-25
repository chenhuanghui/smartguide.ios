#import "_Event.h"

enum EVENT_TYPE
{
    EVENT_TYPE_UNKNOW=-1,
    EVENT_TYPE_BRAND=0,
    EVENT_TYPE_SHOP=1,
};

@interface Event : _Event 
{
}

+(Event*) makeWithData:(NSDictionary*) dict;

-(enum EVENT_TYPE) enumType;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect descRect;

@end
