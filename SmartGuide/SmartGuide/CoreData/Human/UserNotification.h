#import "_UserNotification.h"
#import "Constant.h"

@interface UserNotification : _UserNotification 
{
}

+(UserNotification*) makeWithDictionary:(NSDictionary*) data;
+(UserNotification*) userNotificationWithIDSender:(int) idSender;

-(void) updateNumbers:(NSArray*) numbers;
-(void) updateTotals:(NSArray*) totals;

-(NSString*) time;
-(NSString*) content;
-(enum NOTIFICATION_STATUS) enumStatus;
-(NSString*) displayCount;

@property (nonatomic, strong) NSMutableAttributedString *displayContentAttribute;

@end