// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreShopItem.m instead.

#import "_StoreShopItem.h"
#import "StoreShopItem.h"

#import "DataManager.h"
#import "StoreShop.h"
#import "StoreShop.h"


@implementation _StoreShopItem


@dynamic shopLatest;



@dynamic shopTopSeller;



+(StoreShopItem*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"StoreShopItem" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(StoreShopItem*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoreShopItem" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[StoreShopItem alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryStoreShopItem:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"StoreShopItem"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"StoreShopItem query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(StoreShopItem*) queryStoreShopItemObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"StoreShopItem"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"StoreShopItem query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_StoreShopItem queryStoreShopItem:nil];
    
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



- (NSString*)desc {
	[self willAccessValueForKey:@"desc"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"desc"];
	[self didAccessValueForKey:@"desc"];
	return result;
}

- (void)setDesc:(NSString*)value {
	[self willChangeValueForKey:@"desc"];
	[self setPrimitiveValue:value forKey:@"desc"];
	[self didChangeValueForKey:@"desc"];
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

- (NSString*)image {
	[self willAccessValueForKey:@"image"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"image"];
	[self didAccessValueForKey:@"image"];
	return result;
}

- (void)setImage:(NSString*)value {
	[self willChangeValueForKey:@"image"];
	[self setPrimitiveValue:value forKey:@"image"];
	[self didChangeValueForKey:@"image"];
}

- (NSString*)price {
	[self willAccessValueForKey:@"price"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"price"];
	[self didAccessValueForKey:@"price"];
	return result;
}

- (void)setPrice:(NSString*)value {
	[self willChangeValueForKey:@"price"];
	[self setPrimitiveValue:value forKey:@"price"];
	[self didChangeValueForKey:@"price"];
}

- (NSNumber*)sortOrderLatest {
	[self willAccessValueForKey:@"sortOrderLatest"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"sortOrderLatest"];
	[self didAccessValueForKey:@"sortOrderLatest"];
	return result;
}

- (void)setSortOrderLatest:(NSNumber*)value {
	[self willChangeValueForKey:@"sortOrderLatest"];
	[self setPrimitiveValue:value forKey:@"sortOrderLatest"];
	[self didChangeValueForKey:@"sortOrderLatest"];
}

- (NSNumber*)sortOrderTopSeller {
	[self willAccessValueForKey:@"sortOrderTopSeller"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"sortOrderTopSeller"];
	[self didAccessValueForKey:@"sortOrderTopSeller"];
	return result;
}

- (void)setSortOrderTopSeller:(NSNumber*)value {
	[self willChangeValueForKey:@"sortOrderTopSeller"];
	[self setPrimitiveValue:value forKey:@"sortOrderTopSeller"];
	[self didChangeValueForKey:@"sortOrderTopSeller"];
}

#pragma mark Relationships
    
#pragma mark ShopLatest
- (StoreShop*)shopLatest {
	[self willAccessValueForKey:@"shopLatest"];
	StoreShop *result = [self primitiveValueForKey:@"shopLatest"];
	[self didAccessValueForKey:@"shopLatest"];
	return result;
}

#pragma mark ShopTopSeller
- (StoreShop*)shopTopSeller {
	[self willAccessValueForKey:@"shopTopSeller"];
	StoreShop *result = [self primitiveValueForKey:@"shopTopSeller"];
	[self didAccessValueForKey:@"shopTopSeller"];
	return result;
}


@end