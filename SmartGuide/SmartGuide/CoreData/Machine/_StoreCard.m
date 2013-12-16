// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreCard.m instead.

#import "_StoreCard.h"
#import "StoreCard.h"

#import "DataManager.h"
#import "StoreShopItem.h"


@implementation _StoreCard


@dynamic item;



+(StoreCard*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"StoreCard" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(StoreCard*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoreCard" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[StoreCard alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryStoreCard:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"StoreCard"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"StoreCard query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(StoreCard*) queryStoreCardObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"StoreCard"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"StoreCard query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_StoreCard queryStoreCard:nil];
    
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



- (NSNumber*)idItem {
	[self willAccessValueForKey:@"idItem"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idItem"];
	[self didAccessValueForKey:@"idItem"];
	return result;
}

- (void)setIdItem:(NSNumber*)value {
	[self willChangeValueForKey:@"idItem"];
	[self setPrimitiveValue:value forKey:@"idItem"];
	[self didChangeValueForKey:@"idItem"];
}

- (NSNumber*)quantity {
	[self willAccessValueForKey:@"quantity"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"quantity"];
	[self didAccessValueForKey:@"quantity"];
	return result;
}

- (void)setQuantity:(NSNumber*)value {
	[self willChangeValueForKey:@"quantity"];
	[self setPrimitiveValue:value forKey:@"quantity"];
	[self didChangeValueForKey:@"quantity"];
}

#pragma mark Relationships
    
#pragma mark Item
- (StoreShopItem*)item {
	[self willAccessValueForKey:@"item"];
	StoreShopItem *result = [self primitiveValueForKey:@"item"];
	[self didAccessValueForKey:@"item"];
	return result;
}


@end