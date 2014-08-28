#import "_MessageSender.h"
#import "Enums.h"

@interface MessageSender : _MessageSender 
{
}

+(MessageSender*) makeWithData:(NSDictionary*) data;

-(enum MESSAGE_VIEW_STATUS) enumStatus;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect contentRect;

@end
