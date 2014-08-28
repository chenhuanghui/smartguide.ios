#import "_MessageAction.h"
#import "Enums.h"

@interface MessageAction : _MessageAction 
{
}

+(MessageAction*) makeWithData:(NSDictionary*) data;

-(enum MESSAGE_ACTION_TYPE) enumActionType;

@end
