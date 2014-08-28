#import "_MessageList.h"
#import "Enums.h"

@interface MessageList : _MessageList 
{
}

+(MessageList*) makeWithData:(NSDictionary*) dict;

-(enum MESSAGE_VIEW_STATUS) enumStatus;

@property (nonatomic, assign) CGRect titleRectSmall;
@property (nonatomic, assign) CGRect titleRectFull;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect timeRect;

@end