// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome5.m instead.

#import "_UserHome5.h"
#import "UserHome5.h"

#import "DataManager.h"
#import "UserHome.h"


@implementation _UserHome5


@dynamic home;



+(UserHome5*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserHome5" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserHome5*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserHome5" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserHome5 alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserHome5:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome5"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserHome5 query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(UserHome5*) queryUserHome5Object:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome5"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserHome5 query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_UserHome5 queryUserHome5:nil];
    
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

- (NSString*)cover {
	[self willAccessValueForKey:@"cover"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"cover"];
	[self didAccessValueForKey:@"cover"];
	return result;
}

- (void)setCover:(NSString*)value {
	[self willChangeValueForKey:@"cover"];
	[self setPrimitiveValue:value forKey:@"cover"];
	[self didChangeValueForKey:@"cover"];
}

- (NSNumber*)idStore {
	[self willAccessValueForKey:@"idStore"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idStore"];
	[self didAccessValueForKey:@"idStore"];
	return result;
}

- (void)setIdStore:(NSNumber*)value {
	[self willChangeValueForKey:@"idStore"];
	[self setPrimitiveValue:value forKey:@"idStore"];
	[self didChangeValueForKey:@"idStore"];
}

- (NSString*)numOfPurchase {
	[self willAccessValueForKey:@"numOfPurchase"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numOfPurchase"];
	[self didAccessValueForKey:@"numOfPurchase"];
	return result;
}

- (void)setNumOfPurchase:(NSString*)value {
	[self willChangeValueForKey:@"numOfPurchase"];
	[self setPrimitiveValue:value forKey:@"numOfPurchase"];
	[self didChangeValueForKey:@"numOfPurchase"];
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

- (NSString*)storeName {
	[self willAccessValueForKey:@"storeName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"storeName"];
	[self didAccessValueForKey:@"storeName"];
	return result;
}

- (void)setStoreName:(NSString*)value {
	[self willChangeValueForKey:@"storeName"];
	[self setPrimitiveValue:value forKey:@"storeName"];
	[self didChangeValueForKey:@"storeName"];
}

#pragma mark Relationships
    
#pragma mark Home
- (UserHome*)home {
	[self willAccessValueForKey:@"home"];
	UserHome *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
	return result;
}


@end