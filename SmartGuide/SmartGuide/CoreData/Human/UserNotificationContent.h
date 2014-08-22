#import "_UserNotificationContent.h"
#import "Constant.h"
#import "UserNotificationAction.h"

@interface UserNotificationContent : _UserNotificationContent
{
}

+(UserNotificationContent*) userNotifcationContentWithIDSender:(int) idSender IDMessage:(int) idMessage;
+(UserNotificationContent*) makeWithDictionary:(NSDictionary*) data;

-(enum NOTIFICATION_STATUS) enumStatus;
-(NSArray*) actionTitles;
-(UserNotificationAction*) actionFromTitle:(NSString*) title;

@property (nonatomic, strong) NSNumber *titleHeight;
@property (nonatomic, strong) NSNumber *contentHeight;
@property (nonatomic, strong) NSNumber *actionsHeight;
@property (nonatomic, strong) NSAttributedString *titleAttribute;
@property (nonatomic, strong) NSAttributedString *contentAttribute;
@property (nonatomic, strong) NSNumber *imageHeightForNoti;
@property (nonatomic, strong) NSNumber *videoHeightForNoti;
@property (nonatomic, strong) NSNumber *videoPlaytime;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect titleFrameFull;
@property (nonatomic, assign) CGRect contentFrame;

@end