// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationContent.m instead.

#import "_UserNotificationContent.h"
#import "UserNotificationContent.h"

#import "DataManager.h"
#import "UserNotificationAction.h"
#import "UserNotification.h"


@implementation _UserNotificationContent





@dynamic notification;



+(UserNotificationContent*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserNotificationContent" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserNotificationContent*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserNotificationContent" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserNotificationContent alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserNotificationContent:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserNotificationContent"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserNotificationContent query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(UserNotificationContent*) queryUserNotificationContentObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserNotificationContent"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserNotificationContent query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_UserNotificationContent queryUserNotificationContent:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

+(void) markDeleteAllObjects
{
    for(NSManagedObject *obj in [self allObjects])
    {
        [[DataManager shareInstance].managedObjectContext deleteObject:obj];
    }
}

-(void) markDeleted
{
    [[DataManager shareInstance].managedObjectContext deleteObject:self];
}



- (NSString*)content {
	[self willAccessValueForKey:@"content"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"content"];
	[self didAccessValueForKey:@"content"];
	return result;
}

- (void)setContent:(NSString*)value {
	[self willChangeValueForKey:@"content"];
	[self setPrimitiveValue:value forKey:@"content"];
	[self didChangeValueForKey:@"content"];
}

- (NSNumber*)displayType {
	[self willAccessValueForKey:@"displayType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"displayType"];
	[self didAccessValueForKey:@"displayType"];
	return result;
}

- (void)setDisplayType:(NSNumber*)value {
	[self willChangeValueForKey:@"displayType"];
	[self setPrimitiveValue:value forKey:@"displayType"];
	[self didChangeValueForKey:@"displayType"];
}

- (NSNumber*)highlightUnread {
	[self willAccessValueForKey:@"highlightUnread"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"highlightUnread"];
	[self didAccessValueForKey:@"highlightUnread"];
	return result;
}

- (void)setHighlightUnread:(NSNumber*)value {
	[self willChangeValueForKey:@"highlightUnread"];
	[self setPrimitiveValue:value forKey:@"highlightUnread"];
	[self didChangeValueForKey:@"highlightUnread"];
}

- (NSNumber*)idMessage {
	[self willAccessValueForKey:@"idMessage"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idMessage"];
	[self didAccessValueForKey:@"idMessage"];
	return result;
}

- (void)setIdMessage:(NSNumber*)value {
	[self willChangeValueForKey:@"idMessage"];
	[self setPrimitiveValue:value forKey:@"idMessage"];
	[self didChangeValueForKey:@"idMessage"];
}

- (NSNumber*)idSender {
	[self willAccessValueForKey:@"idSender"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idSender"];
	[self didAccessValueForKey:@"idSender"];
	return result;
}

- (void)setIdSender:(NSNumber*)value {
	[self willChangeValueForKey:@"idSender"];
	[self setPrimitiveValue:value forKey:@"idSender"];
	[self didChangeValueForKey:@"idSender"];
}

- (NSNumber*)idShopLogo {
	[self willAccessValueForKey:@"idShopLogo"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idShopLogo"];
	[self didAccessValueForKey:@"idShopLogo"];
	return result;
}

- (void)setIdShopLogo:(NSNumber*)value {
	[self willChangeValueForKey:@"idShopLogo"];
	[self setPrimitiveValue:value forKey:@"idShopLogo"];
	[self didChangeValueForKey:@"idShopLogo"];
}

- (NSString*)image {
	[self willAccessValueForKey:@"image"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"image"];
	[self didAccessValueForKey:@"image"];
	return result;
}

- (void)setImage:(NSString*)value {
	[self willChangeValueForKey:@"image"];
	[self setPrimitiveValue:value forKey:@"image"];
	[self didChangeValueForKey:@"image"];
}

- (NSNumber*)imageHeight {
	[self willAccessValueForKey:@"imageHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"imageHeight"];
	[self didAccessValueForKey:@"imageHeight"];
	return result;
}

- (void)setImageHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"imageHeight"];
	[self setPrimitiveValue:value forKey:@"imageHeight"];
	[self didChangeValueForKey:@"imageHeight"];
}

- (NSNumber*)imageWidth {
	[self willAccessValueForKey:@"imageWidth"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"imageWidth"];
	[self didAccessValueForKey:@"imageWidth"];
	return result;
}

- (void)setImageWidth:(NSNumber*)value {
	[self willChangeValueForKey:@"imageWidth"];
	[self setPrimitiveValue:value forKey:@"imageWidth"];
	[self didChangeValueForKey:@"imageWidth"];
}

- (NSString*)logo {
	[self willAccessValueForKey:@"logo"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"logo"];
	[self didAccessValueForKey:@"logo"];
	return result;
}

- (void)setLogo:(NSString*)value {
	[self willChangeValueForKey:@"logo"];
	[self setPrimitiveValue:value forKey:@"logo"];
	[self didChangeValueForKey:@"logo"];
}

- (NSNumber*)page {
	[self willAccessValueForKey:@"page"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"page"];
	[self didAccessValueForKey:@"page"];
	return result;
}

- (void)setPage:(NSNumber*)value {
	[self willChangeValueForKey:@"page"];
	[self setPrimitiveValue:value forKey:@"page"];
	[self didChangeValueForKey:@"page"];
}

- (NSString*)sender {
	[self willAccessValueForKey:@"sender"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"sender"];
	[self didAccessValueForKey:@"sender"];
	return result;
}

- (void)setSender:(NSString*)value {
	[self willChangeValueForKey:@"sender"];
	[self setPrimitiveValue:value forKey:@"sender"];
	[self didChangeValueForKey:@"sender"];
}

- (NSNumber*)sortOrder {
	[self willAccessValueForKey:@"sortOrder"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"sortOrder"];
	[self didAccessValueForKey:@"sortOrder"];
	return result;
}

- (void)setSortOrder:(NSNumber*)value {
	[self willChangeValueForKey:@"sortOrder"];
	[self setPrimitiveValue:value forKey:@"sortOrder"];
	[self didChangeValueForKey:@"sortOrder"];
}

- (NSNumber*)status {
	[self willAccessValueForKey:@"status"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"status"];
	[self didAccessValueForKey:@"status"];
	return result;
}

- (void)setStatus:(NSNumber*)value {
	[self willChangeValueForKey:@"status"];
	[self setPrimitiveValue:value forKey:@"status"];
	[self didChangeValueForKey:@"status"];
}

- (NSString*)time {
	[self willAccessValueForKey:@"time"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"time"];
	[self didAccessValueForKey:@"time"];
	return result;
}

- (void)setTime:(NSString*)value {
	[self willChangeValueForKey:@"time"];
	[self setPrimitiveValue:value forKey:@"time"];
	[self didChangeValueForKey:@"time"];
}

- (NSString*)title {
	[self willAccessValueForKey:@"title"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"title"];
	[self didAccessValueForKey:@"title"];
	return result;
}

- (void)setTitle:(NSString*)value {
	[self willChangeValueForKey:@"title"];
	[self setPrimitiveValue:value forKey:@"title"];
	[self didChangeValueForKey:@"title"];
}

- (NSString*)video {
	[self willAccessValueForKey:@"video"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"video"];
	[self didAccessValueForKey:@"video"];
	return result;
}

- (void)setVideo:(NSString*)value {
	[self willChangeValueForKey:@"video"];
	[self setPrimitiveValue:value forKey:@"video"];
	[self didChangeValueForKey:@"video"];
}

- (NSNumber*)videoHeight {
	[self willAccessValueForKey:@"videoHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"videoHeight"];
	[self didAccessValueForKey:@"videoHeight"];
	return result;
}

- (void)setVideoHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"videoHeight"];
	[self setPrimitiveValue:value forKey:@"videoHeight"];
	[self didChangeValueForKey:@"videoHeight"];
}

- (NSString*)videoThumbnail {
	[self willAccessValueForKey:@"videoThumbnail"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"videoThumbnail"];
	[self didAccessValueForKey:@"videoThumbnail"];
	return result;
}

- (void)setVideoThumbnail:(NSString*)value {
	[self willChangeValueForKey:@"videoThumbnail"];
	[self setPrimitiveValue:value forKey:@"videoThumbnail"];
	[self didChangeValueForKey:@"videoThumbnail"];
}

- (NSNumber*)videoWidth {
	[self willAccessValueForKey:@"videoWidth"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"videoWidth"];
	[self didAccessValueForKey:@"videoWidth"];
	return result;
}

- (void)setVideoWidth:(NSNumber*)value {
	[self willChangeValueForKey:@"videoWidth"];
	[self setPrimitiveValue:value forKey:@"videoWidth"];
	[self didChangeValueForKey:@"videoWidth"];
}

#pragma mark Relationships
    
#pragma mark Actions
- (NSSet*)actions {
	[self willAccessValueForKey:@"actions"];
	NSSet *result = [self primitiveValueForKey:@"actions"];
	[self didAccessValueForKey:@"actions"];
	return result;
}

-(NSArray*) actionsObjects
{
    NSSet *set=[self actions];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setActions:(NSSet*)value {
	[self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"actions"] setSet:value];
	[self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addActions:(NSSet*)value {
	[self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"actions"] unionSet:value];
	[self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeActions:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"actions"] minusSet:value];
	[self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addActionsObject:(UserNotificationAction*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"actions"] addObject:value];
	[self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeActionsObject:(UserNotificationAction*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"actions"] removeObject:value];
	[self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllActions
{
    [self removeActions:self.actions];
}

- (NSMutableSet*)actionsSet {
	[self willAccessValueForKey:@"actions"];
	NSMutableSet *result = [self mutableSetValueForKey:@"actions"];
	[self didAccessValueForKey:@"actions"];
	return result;
}

#pragma mark Notification
- (UserNotification*)notification {
	[self willAccessValueForKey:@"notification"];
	UserNotification *result = [self primitiveValueForKey:@"notification"];
	[self didAccessValueForKey:@"notification"];
	return result;
}


#pragma mark Utility

-(void) revert
{
    [[[DataManager shareInstance] managedObjectContext] refreshObject:self mergeChanges:false];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end