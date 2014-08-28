// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MessageList.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define MessageList_ClassName @"MessageList"

#define MessageList_Content @"content"
#define MessageList_HighlightUnread @"highlightUnread"
#define MessageList_IdMessage @"idMessage"
#define MessageList_IdShop @"idShop"
#define MessageList_Image @"image"
#define MessageList_ImageHeight @"imageHeight"
#define MessageList_ImageWidth @"imageWidth"
#define MessageList_Logo @"logo"
#define MessageList_MessageSender @"messageSender"
#define MessageList_Status @"status"
#define MessageList_Time @"time"
#define MessageList_Title @"title"
#define MessageList_Video @"video"
#define MessageList_VideoHeight @"videoHeight"
#define MessageList_VideoThumbnail @"videoThumbnail"
#define MessageList_VideoWidth @"videoWidth"

@class MessageList;
@class MessageAction;
@class MessageSender;

@interface _MessageList : NSManagedObject

+(MessageList*) insert;
+(MessageList*) temporary;
+(NSArray*) queryMessageList:(NSPredicate*) predicate;
+(MessageList*) queryMessageListObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* highlightUnread;
@property (nonatomic, retain) NSNumber* idMessage;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* messageSender;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* video;
@property (nonatomic, retain) NSNumber* videoHeight;
@property (nonatomic, retain) NSString* videoThumbnail;
@property (nonatomic, retain) NSNumber* videoWidth;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Actions
- (NSSet*) actions;
- (NSArray*) actionsObjects;
- (void) addActions:(NSSet*)value;
- (void) removeActions:(NSSet*)value;
- (void) addActionsObject:(MessageAction*)value;
- (void) removeActionsObject:(MessageAction*)value;
- (void) removeAllActions;

#pragma mark Sender
@property (nonatomic, retain) MessageSender* sender;



#pragma mark Utility

-(void) revert;

@end