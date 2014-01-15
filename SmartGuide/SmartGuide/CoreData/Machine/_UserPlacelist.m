// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserPlacelist.m instead.

#import "_UserPlacelist.h"
#import "UserPlacelist.h"

#import "DataManager.h"


@implementation _UserPlacelist


+(UserPlacelist*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserPlacelist" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserPlacelist*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserPlacelist" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserPlacelist alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserPlacelist:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserPlacelist"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserPlacelist query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(UserPlacelist*) queryUserPlacelistObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserPlacelist"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserPlacelist query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_UserPlacelist queryUserPlacelist:nil];
    
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

- (NSNumber*)isTicked {
	[self willAccessValueForKey:@"isTicked"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"isTicked"];
	[self didAccessValueForKey:@"isTicked"];
	return result;
}

- (void)setIsTicked:(NSNumber*)value {
	[self willChangeValueForKey:@"isTicked"];
	[self setPrimitiveValue:value forKey:@"isTicked"];
	[self didChangeValueForKey:@"isTicked"];
}

- (NSString*)name {
	[self willAccessValueForKey:@"name"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"name"];
	[self didAccessValueForKey:@"name"];
	return result;
}

- (void)setName:(NSString*)value {
	[self willChangeValueForKey:@"name"];
	[self setPrimitiveValue:value forKey:@"name"];
	[self didChangeValueForKey:@"name"];
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

#pragma mark Relationships
    

@end