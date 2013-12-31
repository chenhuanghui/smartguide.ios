// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome7.m instead.

#import "_UserHome7.h"
#import "UserHome7.h"

#import "DataManager.h"
#import "UserHome.h"
#import "StoreShop.h"


@implementation _UserHome7


@dynamic home;



@dynamic store;



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

- (NSString*)gotostore {
	[self willAccessValueForKey:@"gotostore"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"gotostore"];
	[self didAccessValueForKey:@"gotostore"];
	return result;
}

- (void)setGotostore:(NSString*)value {
	[self willChangeValueForKey:@"gotostore"];
	[self setPrimitiveValue:value forKey:@"gotostore"];
	[self didChangeValueForKey:@"gotostore"];
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

#pragma mark Store
- (StoreShop*)store {
	[self willAccessValueForKey:@"store"];
	StoreShop *result = [self primitiveValueForKey:@"store"];
	[self didAccessValueForKey:@"store"];
	return result;
}


@end