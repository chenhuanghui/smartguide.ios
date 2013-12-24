// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome7.m instead.

#import "_UserHome7.h"
#import "UserHome7.h"

#import "DataManager.h"
#import "UserHome.h"


@implementation _UserHome7


@dynamic home;



+(UserHome7*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserHome7" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserHome7*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserHome7" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserHome7 alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserHome7:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome7"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserHome7 query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(UserHome7*) queryUserHome7Object:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome7"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserHome7 query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_UserHome7 queryUserHome7:nil];
    
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

- (NSString*)date {
	[self willAccessValueForKey:@"date"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"date"];
	[self didAccessValueForKey:@"date"];
	return result;
}

- (void)setDate:(NSString*)value {
	[self willChangeValueForKey:@"date"];
	[self setPrimitiveValue:value forKey:@"date"];
	[self didChangeValueForKey:@"date"];
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
    
#pragma mark Home
- (UserHome*)home {
	[self willAccessValueForKey:@"home"];
	UserHome *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
	return result;
}


@end