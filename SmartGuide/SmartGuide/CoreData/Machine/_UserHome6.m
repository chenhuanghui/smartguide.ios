// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome6.m instead.

#import "_UserHome6.h"
#import "UserHome6.h"

#import "DataManager.h"
#import "UserHome.h"
#import "Shop.h"


@implementation _UserHome6


@dynamic home;



@dynamic shop;



+(UserHome6*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserHome6" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserHome6*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserHome6" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserHome6 alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserHome6:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome6"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(UserHome6*) queryUserHome6Object:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome6"];
    
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
    NSArray *array=[_UserHome6 queryUserHome6:nil];
    
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

- (NSNumber*)coverHeight {
	[self willAccessValueForKey:@"coverHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"coverHeight"];
	[self didAccessValueForKey:@"coverHeight"];
	return result;
}

- (void)setCoverHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"coverHeight"];
	[self setPrimitiveValue:value forKey:@"coverHeight"];
	[self didChangeValueForKey:@"coverHeight"];
}

- (NSNumber*)coverWidth {
	[self willAccessValueForKey:@"coverWidth"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"coverWidth"];
	[self didAccessValueForKey:@"coverWidth"];
	return result;
}

- (void)setCoverWidth:(NSNumber*)value {
	[self willChangeValueForKey:@"coverWidth"];
	[self setPrimitiveValue:value forKey:@"coverWidth"];
	[self didChangeValueForKey:@"coverWidth"];
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

- (NSString*)gotoshop {
	[self willAccessValueForKey:@"gotoshop"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"gotoshop"];
	[self didAccessValueForKey:@"gotoshop"];
	return result;
}

- (void)setGotoshop:(NSString*)value {
	[self willChangeValueForKey:@"gotoshop"];
	[self setPrimitiveValue:value forKey:@"gotoshop"];
	[self didChangeValueForKey:@"gotoshop"];
}

- (NSString*)shopName {
	[self willAccessValueForKey:@"shopName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"shopName"];
	[self didAccessValueForKey:@"shopName"];
	return result;
}

- (void)setShopName:(NSString*)value {
	[self willChangeValueForKey:@"shopName"];
	[self setPrimitiveValue:value forKey:@"shopName"];
	[self didChangeValueForKey:@"shopName"];
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

#pragma mark Shop
- (Shop*)shop {
	[self willAccessValueForKey:@"shop"];
	Shop *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
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