// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopDetailInfo.m instead.

#import "_ShopDetailInfo.h"
#import "ShopDetailInfo.h"

#import "DataManager.h"
#import "Shop.h"


@implementation _ShopDetailInfo


@dynamic shop;



+(ShopDetailInfo*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopDetailInfo" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopDetailInfo*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopDetailInfo" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopDetailInfo alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopDetailInfo:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopDetailInfo"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopDetailInfo query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(ShopDetailInfo*) queryShopDetailInfoObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopDetailInfo"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopDetailInfo query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_ShopDetailInfo queryShopDetailInfo:nil];
    
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

- (NSString*)header {
	[self willAccessValueForKey:@"header"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"header"];
	[self didAccessValueForKey:@"header"];
	return result;
}

- (void)setHeader:(NSString*)value {
	[self willChangeValueForKey:@"header"];
	[self setPrimitiveValue:value forKey:@"header"];
	[self didChangeValueForKey:@"header"];
}

- (NSNumber*)idShop {
	[self willAccessValueForKey:@"idShop"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idShop"];
	[self didAccessValueForKey:@"idShop"];
	return result;
}

- (void)setIdShop:(NSNumber*)value {
	[self willChangeValueForKey:@"idShop"];
	[self setPrimitiveValue:value forKey:@"idShop"];
	[self didChangeValueForKey:@"idShop"];
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

- (NSNumber*)type {
	[self willAccessValueForKey:@"type"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"type"];
	[self didAccessValueForKey:@"type"];
	return result;
}

- (void)setType:(NSNumber*)value {
	[self willChangeValueForKey:@"type"];
	[self setPrimitiveValue:value forKey:@"type"];
	[self didChangeValueForKey:@"type"];
}

#pragma mark Relationships
    
#pragma mark Shop
- (Shop*)shop {
	[self willAccessValueForKey:@"shop"];
	Shop *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
	return result;
}


@end