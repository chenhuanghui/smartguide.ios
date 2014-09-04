// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationAction.m instead.

#import "_UserNotificationAction.h"
#import "UserNotificationAction.h"

#import "DataManager.h"
#import "UserNotificationContent.h"


@implementation _UserNotificationAction


@dynamic userNotificationContent;



+(UserNotificationAction*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserNotificationAction" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserNotificationAction*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserNotificationAction" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserNotificationAction alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserNotificationAction:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserNotificationAction"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(UserNotificationAction*) queryUserNotificationActionObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserNotificationAction"];
    
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
    NSArray *array=[_UserNotificationAction queryUserNotificationAction:nil];
    
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

- (NSNumber*)actionTitleWidth {
	[self willAccessValueForKey:@"actionTitleWidth"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"actionTitleWidth"];
	[self didAccessValueForKey:@"actionTitleWidth"];
	return result;
}

- (void)setActionTitleWidth:(NSNumber*)value {
	[self willChangeValueForKey:@"actionTitleWidth"];
	[self setPrimitiveValue:value forKey:@"actionTitleWidth"];
	[self didChangeValueForKey:@"actionTitleWidth"];
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

- (NSNumber*)color {
	[self willAccessValueForKey:@"color"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"color"];
	[self didAccessValueForKey:@"color"];
	return result;
}

- (void)setColor:(NSNumber*)value {
	[self willChangeValueForKey:@"color"];
	[self setPrimitiveValue:value forKey:@"color"];
	[self didChangeValueForKey:@"color"];
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

- (NSNumber*)method {
	[self willAccessValueForKey:@"method"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"method"];
	[self didAccessValueForKey:@"method"];
	return result;
}

- (void)setMethod:(NSNumber*)value {
	[self willChangeValueForKey:@"method"];
	[self setPrimitiveValue:value forKey:@"method"];
	[self didChangeValueForKey:@"method"];
}

- (NSString*)params {
	[self willAccessValueForKey:@"params"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"params"];
	[self didAccessValueForKey:@"params"];
	return result;
}

- (void)setParams:(NSString*)value {
	[self willChangeValueForKey:@"params"];
	[self setPrimitiveValue:value forKey:@"params"];
	[self didChangeValueForKey:@"params"];
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
    
#pragma mark UserNotificationContent
- (UserNotificationContent*)userNotificationContent {
	[self willAccessValueForKey:@"userNotificationContent"];
	UserNotificationContent *result = [self primitiveValueForKey:@"userNotificationContent"];
	[self didAccessValueForKey:@"userNotificationContent"];
	return result;
}


#pragma mark Utility

-(void) revert
{
    [self.managedObjectContext refreshObject:self mergeChanges:false];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end