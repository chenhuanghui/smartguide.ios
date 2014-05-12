// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationContent.m instead.

#import "_UserNotificationContent.h"
#import "UserNotificationContent.h"

#import "DataManager.h"
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

- (NSNumber*)shopListType {
	[self willAccessValueForKey:@"shopListType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shopListType"];
	[self didAccessValueForKey:@"shopListType"];
	return result;
}

- (void)setShopListType:(NSNumber*)value {
	[self willChangeValueForKey:@"shopListType"];
	[self setPrimitiveValue:value forKey:@"shopListType"];
	[self didChangeValueForKey:@"shopListType"];
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