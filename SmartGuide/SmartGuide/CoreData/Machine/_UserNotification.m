// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.m instead.

#import "_UserNotification.h"
#import "UserNotification.h"

#import "DataManager.h"
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

- (NSNumber*)numberAll {
	[self willAccessValueForKey:@"numberAll"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"numberAll"];
	[self didAccessValueForKey:@"numberAll"];
	return result;
}

- (void)setNumberAll:(NSNumber*)value {
	[self willChangeValueForKey:@"numberAll"];
	[self setPrimitiveValue:value forKey:@"numberAll"];
	[self didChangeValueForKey:@"numberAll"];
}

- (NSNumber*)numberRead {
	[self willAccessValueForKey:@"numberRead"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"numberRead"];
	[self didAccessValueForKey:@"numberRead"];
	return result;
}

- (void)setNumberRead:(NSNumber*)value {
	[self willChangeValueForKey:@"numberRead"];
	[self setPrimitiveValue:value forKey:@"numberRead"];
	[self didChangeValueForKey:@"numberRead"];
}

- (NSNumber*)numberUnread {
	[self willAccessValueForKey:@"numberUnread"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"numberUnread"];
	[self didAccessValueForKey:@"numberUnread"];
	return result;
}

- (void)setNumberUnread:(NSNumber*)value {
	[self willChangeValueForKey:@"numberUnread"];
	[self setPrimitiveValue:value forKey:@"numberUnread"];
	[self didChangeValueForKey:@"numberUnread"];
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

- (NSString*)totalAll {
	[self willAccessValueForKey:@"totalAll"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"totalAll"];
	[self didAccessValueForKey:@"totalAll"];
	return result;
}

- (void)setTotalAll:(NSString*)value {
	[self willChangeValueForKey:@"totalAll"];
	[self setPrimitiveValue:value forKey:@"totalAll"];
	[self didChangeValueForKey:@"totalAll"];
}

- (NSString*)totalRead {
	[self willAccessValueForKey:@"totalRead"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"totalRead"];
	[self didAccessValueForKey:@"totalRead"];
	return result;
}

- (void)setTotalRead:(NSString*)value {
	[self willChangeValueForKey:@"totalRead"];
	[self setPrimitiveValue:value forKey:@"totalRead"];
	[self didChangeValueForKey:@"totalRead"];
}

- (NSString*)totalUnread {
	[self willAccessValueForKey:@"totalUnread"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"totalUnread"];
	[self didAccessValueForKey:@"totalUnread"];
	return result;
}

- (void)setTotalUnread:(NSString*)value {
	[self willChangeValueForKey:@"totalUnread"];
	[self setPrimitiveValue:value forKey:@"totalUnread"];
	[self didChangeValueForKey:@"totalUnread"];
}

#pragma mark Relationships
    
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