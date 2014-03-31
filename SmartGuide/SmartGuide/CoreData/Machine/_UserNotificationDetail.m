// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationDetail.m instead.

#import "_UserNotificationDetail.h"
#import "UserNotificationDetail.h"

#import "DataManager.h"
#import "UserNotification.h"


@implementation _UserNotificationDetail


@dynamic userNotification;



+(UserNotificationDetail*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserNotificationDetail" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserNotificationDetail*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserNotificationDetail" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserNotificationDetail alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserNotificationDetail:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserNotificationDetail"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserNotificationDetail query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(UserNotificationDetail*) queryUserNotificationDetailObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserNotificationDetail"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserNotificationDetail query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_UserNotificationDetail queryUserNotificationDetail:nil];
    
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



- (NSNumber*)actionDataIDPlace {
	[self willAccessValueForKey:@"actionDataIDPlace"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"actionDataIDPlace"];
	[self didAccessValueForKey:@"actionDataIDPlace"];
	return result;
}

- (void)setActionDataIDPlace:(NSNumber*)value {
	[self willChangeValueForKey:@"actionDataIDPlace"];
	[self setPrimitiveValue:value forKey:@"actionDataIDPlace"];
	[self didChangeValueForKey:@"actionDataIDPlace"];
}

- (NSNumber*)actionDataIDShop {
	[self willAccessValueForKey:@"actionDataIDShop"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"actionDataIDShop"];
	[self didAccessValueForKey:@"actionDataIDShop"];
	return result;
}

- (void)setActionDataIDShop:(NSNumber*)value {
	[self willChangeValueForKey:@"actionDataIDShop"];
	[self setPrimitiveValue:value forKey:@"actionDataIDShop"];
	[self didChangeValueForKey:@"actionDataIDShop"];
}

- (NSString*)actionDataKeyword {
	[self willAccessValueForKey:@"actionDataKeyword"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"actionDataKeyword"];
	[self didAccessValueForKey:@"actionDataKeyword"];
	return result;
}

- (void)setActionDataKeyword:(NSString*)value {
	[self willChangeValueForKey:@"actionDataKeyword"];
	[self setPrimitiveValue:value forKey:@"actionDataKeyword"];
	[self didChangeValueForKey:@"actionDataKeyword"];
}

- (NSString*)actionScreen {
	[self willAccessValueForKey:@"actionScreen"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"actionScreen"];
	[self didAccessValueForKey:@"actionScreen"];
	return result;
}

- (void)setActionScreen:(NSString*)value {
	[self willChangeValueForKey:@"actionScreen"];
	[self setPrimitiveValue:value forKey:@"actionScreen"];
	[self didChangeValueForKey:@"actionScreen"];
}

- (NSString*)actionTitle {
	[self willAccessValueForKey:@"actionTitle"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"actionTitle"];
	[self didAccessValueForKey:@"actionTitle"];
	return result;
}

- (void)setActionTitle:(NSString*)value {
	[self willChangeValueForKey:@"actionTitle"];
	[self setPrimitiveValue:value forKey:@"actionTitle"];
	[self didChangeValueForKey:@"actionTitle"];
}

- (NSString*)desc {
	[self willAccessValueForKey:@"desc"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"desc"];
	[self didAccessValueForKey:@"desc"];
	return result;
}

- (void)setDesc:(NSString*)value {
	[self willChangeValueForKey:@"desc"];
	[self setPrimitiveValue:value forKey:@"desc"];
	[self didChangeValueForKey:@"desc"];
}

- (NSString*)icon {
	[self willAccessValueForKey:@"icon"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"icon"];
	[self didAccessValueForKey:@"icon"];
	return result;
}

- (void)setIcon:(NSString*)value {
	[self willChangeValueForKey:@"icon"];
	[self setPrimitiveValue:value forKey:@"icon"];
	[self didChangeValueForKey:@"icon"];
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
    
#pragma mark UserNotification
- (UserNotification*)userNotification {
	[self willAccessValueForKey:@"userNotification"];
	UserNotification *result = [self primitiveValueForKey:@"userNotification"];
	[self didAccessValueForKey:@"userNotification"];
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