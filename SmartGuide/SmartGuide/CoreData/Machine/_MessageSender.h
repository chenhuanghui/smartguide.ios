// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MessageSender.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define MessageSender_ClassName @"MessageSender"

#define MessageSender_Content @"content"
#define MessageSender_CountAll @"countAll"
#define MessageSender_CountRead @"countRead"
#define MessageSender_CountUnread @"countUnread"
#define MessageSender_HighlightUnread @"highlightUnread"
#define MessageSender_IdMessageNewest @"idMessageNewest"
#define MessageSender_IdSender @"idSender"
#define MessageSender_NumAll @"numAll"
#define MessageSender_NumRead @"numRead"
#define MessageSender_NumUnread @"numUnread"
#define MessageSender_Sender @"sender"
#define MessageSender_Status @"status"

@class MessageSender;
@class MessageList;

@interface _MessageSender : NSManagedObject

+(MessageSender*) insert;
+(MessageSender*) temporary;
+(NSArray*) queryMessageSender:(NSPredicate*) predicate;
+(MessageSender*) queryMessageSenderObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* countAll;
@property (nonatomic, retain) NSNumber* countRead;
@property (nonatomic, retain) NSNumber* countUnread;
@property (nonatomic, retain) NSNumber* highlightUnread;
@property (nonatomic, retain) NSNumber* idMessageNewest;
@property (nonatomic, retain) NSNumber* idSender;
@property (nonatomic, retain) NSString* numAll;
@property (nonatomic, retain) NSString* numRead;
@property (nonatomic, retain) NSString* numUnread;
@property (nonatomic, retain) NSString* sender;
@property (nonatomic, retain) NSNumber* status;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Messages
- (NSSet*) messages;
- (NSArray*) messagesObjects;
- (void) addMessages:(NSSet*)value;
- (void) removeMessages:(NSSet*)value;
- (void) addMessagesObject:(MessageList*)value;
- (void) removeMessagesObject:(MessageList*)value;
- (void) removeAllMessages;



#pragma mark Utility

-(void) revert;

@end