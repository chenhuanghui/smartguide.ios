// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Filter.m instead.

#import "_Filter.h"
#import "Filter.h"

#import "DataManager.h"
#import "User.h"


@implementation _Filter


@dynamic user;



+(Filter*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Filter" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Filter*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Filter" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Filter alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryFilter:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Filter"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Filter query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(Filter*) queryFilterObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Filter"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Filter query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_Filter queryFilter:nil];
    
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



- (NSNumber*)distance {
	[self willAccessValueForKey:@"distance"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"distance"];
	[self didAccessValueForKey:@"distance"];
	return result;
}

- (void)setDistance:(NSNumber*)value {
	[self willChangeValueForKey:@"distance"];
	[self setPrimitiveValue:value forKey:@"distance"];
	[self didChangeValueForKey:@"distance"];
}

- (NSNumber*)drink {
	[self willAccessValueForKey:@"drink"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"drink"];
	[self didAccessValueForKey:@"drink"];
	return result;
}

- (void)setDrink:(NSNumber*)value {
	[self willChangeValueForKey:@"drink"];
	[self setPrimitiveValue:value forKey:@"drink"];
	[self didChangeValueForKey:@"drink"];
}

- (NSNumber*)education {
	[self willAccessValueForKey:@"education"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"education"];
	[self didAccessValueForKey:@"education"];
	return result;
}

- (void)setEducation:(NSNumber*)value {
	[self willChangeValueForKey:@"education"];
	[self setPrimitiveValue:value forKey:@"education"];
	[self didChangeValueForKey:@"education"];
}

- (NSNumber*)entertaiment {
	[self willAccessValueForKey:@"entertaiment"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"entertaiment"];
	[self didAccessValueForKey:@"entertaiment"];
	return result;
}

- (void)setEntertaiment:(NSNumber*)value {
	[self willChangeValueForKey:@"entertaiment"];
	[self setPrimitiveValue:value forKey:@"entertaiment"];
	[self didChangeValueForKey:@"entertaiment"];
}

- (NSNumber*)fashion {
	[self willAccessValueForKey:@"fashion"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"fashion"];
	[self didAccessValueForKey:@"fashion"];
	return result;
}

- (void)setFashion:(NSNumber*)value {
	[self willChangeValueForKey:@"fashion"];
	[self setPrimitiveValue:value forKey:@"fashion"];
	[self didChangeValueForKey:@"fashion"];
}

- (NSNumber*)food {
	[self willAccessValueForKey:@"food"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"food"];
	[self didAccessValueForKey:@"food"];
	return result;
}

- (void)setFood:(NSNumber*)value {
	[self willChangeValueForKey:@"food"];
	[self setPrimitiveValue:value forKey:@"food"];
	[self didChangeValueForKey:@"food"];
}

- (NSNumber*)health {
	[self willAccessValueForKey:@"health"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"health"];
	[self didAccessValueForKey:@"health"];
	return result;
}

- (void)setHealth:(NSNumber*)value {
	[self willChangeValueForKey:@"health"];
	[self setPrimitiveValue:value forKey:@"health"];
	[self didChangeValueForKey:@"health"];
}

- (NSNumber*)idUser {
	[self willAccessValueForKey:@"idUser"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idUser"];
	[self didAccessValueForKey:@"idUser"];
	return result;
}

- (void)setIdUser:(NSNumber*)value {
	[self willChangeValueForKey:@"idUser"];
	[self setPrimitiveValue:value forKey:@"idUser"];
	[self didChangeValueForKey:@"idUser"];
}

- (NSNumber*)isShopKM {
	[self willAccessValueForKey:@"isShopKM"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"isShopKM"];
	[self didAccessValueForKey:@"isShopKM"];
	return result;
}

- (void)setIsShopKM:(NSNumber*)value {
	[self willChangeValueForKey:@"isShopKM"];
	[self setPrimitiveValue:value forKey:@"isShopKM"];
	[self didChangeValueForKey:@"isShopKM"];
}

- (NSNumber*)mostLike {
	[self willAccessValueForKey:@"mostLike"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"mostLike"];
	[self didAccessValueForKey:@"mostLike"];
	return result;
}

- (void)setMostLike:(NSNumber*)value {
	[self willChangeValueForKey:@"mostLike"];
	[self setPrimitiveValue:value forKey:@"mostLike"];
	[self didChangeValueForKey:@"mostLike"];
}

- (NSNumber*)mostView {
	[self willAccessValueForKey:@"mostView"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"mostView"];
	[self didAccessValueForKey:@"mostView"];
	return result;
}

- (void)setMostView:(NSNumber*)value {
	[self willChangeValueForKey:@"mostView"];
	[self setPrimitiveValue:value forKey:@"mostView"];
	[self didChangeValueForKey:@"mostView"];
}

- (NSNumber*)production {
	[self willAccessValueForKey:@"production"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"production"];
	[self didAccessValueForKey:@"production"];
	return result;
}

- (void)setProduction:(NSNumber*)value {
	[self willChangeValueForKey:@"production"];
	[self setPrimitiveValue:value forKey:@"production"];
	[self didChangeValueForKey:@"production"];
}

- (NSNumber*)travel {
	[self willAccessValueForKey:@"travel"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"travel"];
	[self didAccessValueForKey:@"travel"];
	return result;
}

- (void)setTravel:(NSNumber*)value {
	[self willChangeValueForKey:@"travel"];
	[self setPrimitiveValue:value forKey:@"travel"];
	[self didChangeValueForKey:@"travel"];
}

#pragma mark Relationships
    
#pragma mark User
- (User*)user {
	[self willAccessValueForKey:@"user"];
	User *result = [self primitiveValueForKey:@"user"];
	[self didAccessValueForKey:@"user"];
	return result;
}


@end