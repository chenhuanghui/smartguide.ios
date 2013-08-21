// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionDetail.m instead.

#import "_PromotionDetail.h"
#import "PromotionDetail.h"

#import "DataManager.h"
#import "PromotionRequire.h"
#import "Shop.h"


@implementation _PromotionDetail





@dynamic shop;



+(PromotionDetail*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"PromotionDetail" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(PromotionDetail*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PromotionDetail" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[PromotionDetail alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryPromotionDetail:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PromotionDetail"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"PromotionDetail query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(PromotionDetail*) queryPromotionDetailObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PromotionDetail"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"PromotionDetail query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_PromotionDetail queryPromotionDetail:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"PromotionDetail save error %@",error);
        
    return result;
}



- (NSNumber*)cost {
	[self willAccessValueForKey:@"cost"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"cost"];
	[self didAccessValueForKey:@"cost"];
	return result;
}

- (void)setCost:(NSNumber*)value {
	[self willChangeValueForKey:@"cost"];
	[self setPrimitiveValue:value forKey:@"cost"];
	[self didChangeValueForKey:@"cost"];
}

- (NSString*)duration {
	[self willAccessValueForKey:@"duration"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"duration"];
	[self didAccessValueForKey:@"duration"];
	return result;
}

- (void)setDuration:(NSString*)value {
	[self willChangeValueForKey:@"duration"];
	[self setPrimitiveValue:value forKey:@"duration"];
	[self didChangeValueForKey:@"duration"];
}

- (NSNumber*)idAwardType2 {
	[self willAccessValueForKey:@"idAwardType2"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idAwardType2"];
	[self didAccessValueForKey:@"idAwardType2"];
	return result;
}

- (void)setIdAwardType2:(NSNumber*)value {
	[self willChangeValueForKey:@"idAwardType2"];
	[self setPrimitiveValue:value forKey:@"idAwardType2"];
	[self didChangeValueForKey:@"idAwardType2"];
}

- (NSNumber*)money {
	[self willAccessValueForKey:@"money"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"money"];
	[self didAccessValueForKey:@"money"];
	return result;
}

- (void)setMoney:(NSNumber*)value {
	[self willChangeValueForKey:@"money"];
	[self setPrimitiveValue:value forKey:@"money"];
	[self didChangeValueForKey:@"money"];
}

- (NSNumber*)promotionType {
	[self willAccessValueForKey:@"promotionType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"promotionType"];
	[self didAccessValueForKey:@"promotionType"];
	return result;
}

- (void)setPromotionType:(NSNumber*)value {
	[self willChangeValueForKey:@"promotionType"];
	[self setPrimitiveValue:value forKey:@"promotionType"];
	[self didChangeValueForKey:@"promotionType"];
}

- (NSNumber*)sgp {
	[self willAccessValueForKey:@"sgp"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"sgp"];
	[self didAccessValueForKey:@"sgp"];
	return result;
}

- (void)setSgp:(NSNumber*)value {
	[self willChangeValueForKey:@"sgp"];
	[self setPrimitiveValue:value forKey:@"sgp"];
	[self didChangeValueForKey:@"sgp"];
}

- (NSNumber*)sp {
	[self willAccessValueForKey:@"sp"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"sp"];
	[self didAccessValueForKey:@"sp"];
	return result;
}

- (void)setSp:(NSNumber*)value {
	[self willChangeValueForKey:@"sp"];
	[self setPrimitiveValue:value forKey:@"sp"];
	[self didChangeValueForKey:@"sp"];
}

#pragma mark Relationships
    
#pragma mark Requires
- (NSSet*)requires {
	[self willAccessValueForKey:@"requires"];
	NSSet *result = [self primitiveValueForKey:@"requires"];
	[self didAccessValueForKey:@"requires"];
	return result;
}

-(NSArray*) requiresObjects
{
    NSSet *set=[self requires];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setRequires:(NSSet*)value {
	[self willChangeValueForKey:@"requires" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"requires"] setSet:value];
	[self didChangeValueForKey:@"requires" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addRequires:(NSSet*)value {
	[self willChangeValueForKey:@"requires" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"requires"] unionSet:value];
	[self didChangeValueForKey:@"requires" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeRequires:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"requires" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"requires"] minusSet:value];
	[self didChangeValueForKey:@"requires" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addRequiresObject:(PromotionRequire*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"requires" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"requires"] addObject:value];
	[self didChangeValueForKey:@"requires" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeRequiresObject:(PromotionRequire*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"requires" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"requires"] removeObject:value];
	[self didChangeValueForKey:@"requires" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)requiresSet {
	[self willAccessValueForKey:@"requires"];
	NSMutableSet *result = [self mutableSetValueForKey:@"requires"];
	[self didAccessValueForKey:@"requires"];
	return result;
}

#pragma mark Shop
- (Shop*)shop {
	[self willAccessValueForKey:@"shop"];
	Shop *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
	return result;
}


@end