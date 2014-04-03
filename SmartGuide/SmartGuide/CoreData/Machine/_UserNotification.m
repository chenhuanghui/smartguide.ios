// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.m instead.

#import "_UserNotification.h"
#import "UserNotification.h"

#import "DataManager.h"


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

#pragma mark Relationships
    

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