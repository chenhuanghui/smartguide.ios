// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MessageAction.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define MessageAction_ClassName @"MessageAction"

#define MessageAction_ActionTitle @"actionTitle"
#define MessageAction_ActionType @"actionType"
#define MessageAction_IdPlacelist @"idPlacelist"
#define MessageAction_IdShop @"idShop"
#define MessageAction_IdShops @"idShops"
#define MessageAction_Keywords @"keywords"
#define MessageAction_Method @"method"
#define MessageAction_Params @"params"
#define MessageAction_SortOrder @"sortOrder"
#define MessageAction_Url @"url"

@class MessageAction;
@class MessageList;

@interface _MessageAction : NSManagedObject

+(MessageAction*) insert;
+(MessageAction*) temporary;
+(NSArray*) queryMessageAction:(NSPredicate*) predicate;
+(MessageAction*) queryMessageActionObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* actionTitle;
@property (nonatomic, retain) NSNumber* actionType;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* keywords;
@property (nonatomic, retain) NSNumber* method;
@property (nonatomic, retain) NSString* params;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* url;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Message
@property (nonatomic, retain) MessageList* message;



#pragma mark Utility

-(void) revert;

@end