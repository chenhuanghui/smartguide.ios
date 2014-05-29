// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.m instead.

#import "_UserNotification.h"
#import "UserNotification.h"

#import "DataManager.h"
#import "UserNotificationAction.h"
#import "UserNotificationContent.h"


@implementation _UserNotification








+(UserNotification*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserNotification" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserNotification*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserNotification" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserNotification alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserNotification:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserNotification"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserNotification query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(UserNotification*) queryUserNotificationObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserNotification"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserNotification query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_UserNotification queryUserNotification:nil];
    
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

- (NSNumber*)idNotification {
	[self willAccessValueForKey:@"idNotification"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idNotification"];
	[self didAccessValueForKey:@"idNotification"];
	return result;
}

- (void)setIdNotification:(NSNumber*)value {
	[self willChangeValueForKey:@"idNotification"];
	[self setPrimitiveValue:value forKey:@"idNotification"];
	[self didChangeValueForKey:@"idNotification"];
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

#pragma mark NotificationContents
- (NSSet*)notificationContents {
	[self willAccessValueForKey:@"notificationContents"];
	NSSet *result = [self primitiveValueForKey:@"notificationContents"];
	[self didAccessValueForKey:@"notificationContents"];
	return result;
}

-(NSArray*) notificationContentsObjects
{
    NSSet *set=[self notificationContents];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setNotificationContents:(NSSet*)value {
	[self willChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"notificationContents"] setSet:value];
	[self didChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addNotificationContents:(NSSet*)value {
	[self willChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"notificationContents"] unionSet:value];
	[self didChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeNotificationContents:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"notificationContents"] minusSet:value];
	[self didChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addNotificationContentsObject:(UserNotificationContent*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"notificationContents"] addObject:value];
	[self didChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeNotificationContentsObject:(UserNotificationContent*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"notificationContents"] removeObject:value];
	[self didChangeValueForKey:@"notificationContents" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllNotificationContents
{
    [self removeNotificationContents:self.notificationContents];
}

- (NSMutableSet*)notificationContentsSet {
	[self willAccessValueForKey:@"notificationContents"];
	NSMutableSet *result = [self mutableSetValueForKey:@"notificationContents"];
	[self didAccessValueForKey:@"notificationContents"];
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