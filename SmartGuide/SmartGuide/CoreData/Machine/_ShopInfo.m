// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfo.m instead.

#import "_ShopInfo.h"
#import "ShopInfo.h"

#import "DataManager.h"
#import "HomeShop.h"


@implementation _ShopInfo


@dynamic home;



+(ShopInfo*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopInfo" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopInfo*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopInfo" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopInfo alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopInfo:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfo"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopInfo*) queryShopInfoObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfo"];
    
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
    NSArray *array=[_ShopInfo queryShopInfo:nil];
    
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

- (NSString*)logo {
	[self willAccessValueForKey:@"logo"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"logo"];
	[self didAccessValueForKey:@"logo"];
	return result;
}

- (void)setLogo:(NSString*)value {
	[self willChangeValueForKey:@"logo"];
	[self setPrimitiveValue:value forKey:@"logo"];
	[self didChangeValueForKey:@"logo"];
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

- (NSNumber*)shopLat {
	[self willAccessValueForKey:@"shopLat"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shopLat"];
	[self didAccessValueForKey:@"shopLat"];
	return result;
}

- (void)setShopLat:(NSNumber*)value {
	[self willChangeValueForKey:@"shopLat"];
	[self setPrimitiveValue:value forKey:@"shopLat"];
	[self didChangeValueForKey:@"shopLat"];
}

- (NSNumber*)shopLng {
	[self willAccessValueForKey:@"shopLng"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shopLng"];
	[self didAccessValueForKey:@"shopLng"];
	return result;
}

- (void)setShopLng:(NSNumber*)value {
	[self willChangeValueForKey:@"shopLng"];
	[self setPrimitiveValue:value forKey:@"shopLng"];
	[self didChangeValueForKey:@"shopLng"];
}

#pragma mark Relationships
    
#pragma mark Home
- (HomeShop*)home {
	[self willAccessValueForKey:@"home"];
	HomeShop *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
	return result;
}


#pragma mark Utility

-(void) revert
{
    [self.managedObjectContext refreshObject:self mergeChanges:false];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end