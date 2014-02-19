// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome3.m instead.

#import "_UserHome3.h"
#import "UserHome3.h"

#import "DataManager.h"
#import "UserHome.h"
#import "Placelist.h"


@implementation _UserHome3


@dynamic home;



@dynamic place;



+(UserHome3*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserHome3" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserHome3*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserHome3" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserHome3 alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserHome3:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome3"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserHome3 query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(UserHome3*) queryUserHome3Object:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome3"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserHome3 query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_UserHome3 queryUserHome3:nil];
    
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

- (NSString*)numOfShop {
	[self willAccessValueForKey:@"numOfShop"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numOfShop"];
	[self didAccessValueForKey:@"numOfShop"];
	return result;
}

- (void)setNumOfShop:(NSString*)value {
	[self willChangeValueForKey:@"numOfShop"];
	[self setPrimitiveValue:value forKey:@"numOfShop"];
	[self didChangeValueForKey:@"numOfShop"];
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

#pragma mark Place
- (Placelist*)place {
	[self willAccessValueForKey:@"place"];
	Placelist *result = [self primitiveValueForKey:@"place"];
	[self didAccessValueForKey:@"place"];
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