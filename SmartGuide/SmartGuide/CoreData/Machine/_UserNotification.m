// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.m instead.

#import "_UserNotification.h"
#import "UserNotification.h"

#import "DataManager.h"
#import "UserNotificationContent.h"


@implementation _UserNotification


@dynamic notificationContents;



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



- (NSNumber*)actionType {
	[self willAccessValueForKey:@"actionType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"actionType"];
	[self didAccessValueForKey:@"actionType"];
	return result;
}

- (void)setActionType:(NSNumber*)value {
	[self willChangeValueForKey:@"actionType"];
	[self setPrimitiveValue:value forKey:@"actionType"];
	[self didChangeValueForKey:@"actionType"];
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

- (NSString*)highlight {
	[self willAccessValueForKey:@"highlight"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"highlight"];
	[self didAccessValueForKey:@"highlight"];
	return result;
}

- (void)setHighlight:(NSString*)value {
	[self willChangeValueForKey:@"highlight"];
	[self setPrimitiveValue:value forKey:@"highlight"];
	[self didChangeValueForKey:@"highlight"];
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

- (NSNumber*)idPlacelist {
	[self willAccessValueForKey:@"idPlacelist"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idPlacelist"];
	[self didAccessValueForKey:@"idPlacelist"];
	return result;
}

- (void)setIdPlacelist:(NSNumber*)value {
	[self willChangeValueForKey:@"idPlacelist"];
	[self setPrimitiveValue:value forKey:@"idPlacelist"];
	[self didChangeValueForKey:@"idPlacelist"];
}

- (NSNumber*)idShop {
	[self willAccessValueForKey:@"idShop"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idShop"];
	[self didAccessValueForKey:@"idShop"];
	return result;
}

- (void)setIdShop:(NSNumber*)value {
	[self willChangeValueForKey:@"idShop"];
	[self setPrimitiveValue:value forKey:@"idShop"];
	[self didChangeValueForKey:@"idShop"];
}

- (NSString*)idShops {
	[self willAccessValueForKey:@"idShops"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"idShops"];
	[self didAccessValueForKey:@"idShops"];
	return result;
}

- (void)setIdShops:(NSString*)value {
	[self willChangeValueForKey:@"idShops"];
	[self setPrimitiveValue:value forKey:@"idShops"];
	[self didChangeValueForKey:@"idShops"];
}

- (NSString*)keywords {
	[self willAccessValueForKey:@"keywords"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"keywords"];
	[self didAccessValueForKey:@"keywords"];
	return result;
}

- (void)setKeywords:(NSString*)value {
	[self willChangeValueForKey:@"keywords"];
	[self setPrimitiveValue:value forKey:@"keywords"];
	[self didChangeValueForKey:@"keywords"];
}

- (NSNumber*)readAction {
	[self willAccessValueForKey:@"readAction"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"readAction"];
	[self didAccessValueForKey:@"readAction"];
	return result;
}

- (void)setReadAction:(NSNumber*)value {
	[self willChangeValueForKey:@"readAction"];
	[self setPrimitiveValue:value forKey:@"readAction"];
	[self didChangeValueForKey:@"readAction"];
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

- (NSString*)url {
	[self willAccessValueForKey:@"url"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"url"];
	[self didAccessValueForKey:@"url"];
	return result;
}

- (void)setUrl:(NSString*)value {
	[self willChangeValueForKey:@"url"];
	[self setPrimitiveValue:value forKey:@"url"];
	[self didChangeValueForKey:@"url"];
}

#pragma mark Relationships
    
#pragma mark NotificationContents
- (UserNotificationContent*)notificationContents {
	[self willAccessValueForKey:@"notificationContents"];
	UserNotificationContent *result = [self primitiveValueForKey:@"notificationContents"];
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