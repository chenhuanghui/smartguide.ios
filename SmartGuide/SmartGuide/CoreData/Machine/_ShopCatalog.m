// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopCatalog.m instead.

#import "_ShopCatalog.h"
#import "ShopCatalog.h"

#import "DataManager.h"
#import "Shop.h"


@implementation _ShopCatalog





+(ShopCatalog*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopCatalog" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopCatalog*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopCatalog" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopCatalog alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopCatalog:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopCatalog"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopCatalog query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(ShopCatalog*) queryShopCatalogObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopCatalog"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopCatalog query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_ShopCatalog queryShopCatalog:nil];
    
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

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"ShopCatalog save error %@",error);
        
    return result;
}



- (NSNumber*)count {
	[self willAccessValueForKey:@"count"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"count"];
	[self didAccessValueForKey:@"count"];
	return result;
}

- (void)setCount:(NSNumber*)value {
	[self willChangeValueForKey:@"count"];
	[self setPrimitiveValue:value forKey:@"count"];
	[self didChangeValueForKey:@"count"];
}

- (NSNumber*)idCatalog {
	[self willAccessValueForKey:@"idCatalog"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idCatalog"];
	[self didAccessValueForKey:@"idCatalog"];
	return result;
}

- (void)setIdCatalog:(NSNumber*)value {
	[self willChangeValueForKey:@"idCatalog"];
	[self setPrimitiveValue:value forKey:@"idCatalog"];
	[self didChangeValueForKey:@"idCatalog"];
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

#pragma mark Relationships
    
#pragma mark Shops
- (NSSet*)shops {
	[self willAccessValueForKey:@"shops"];
	NSSet *result = [self primitiveValueForKey:@"shops"];
	[self didAccessValueForKey:@"shops"];
	return result;
}

-(NSArray*) shopsObjects
{
    NSSet *set=[self shops];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setShops:(NSSet*)value {
	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shops"] setSet:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addShops:(NSSet*)value {
	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shops"] unionSet:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeShops:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shops"] minusSet:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addShopsObject:(Shop*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shops"] addObject:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeShopsObject:(Shop*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shops"] removeObject:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)shopsSet {
	[self willAccessValueForKey:@"shops"];
	NSMutableSet *result = [self mutableSetValueForKey:@"shops"];
	[self didAccessValueForKey:@"shops"];
	return result;
}


@end