// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopKM2.m instead.

#import "_ShopKM2.h"
#import "ShopKM2.h"

#import "DataManager.h"
#import "KM2Voucher.h"
#import "Shop.h"


@implementation _ShopKM2





@dynamic shop;



+(ShopKM2*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopKM2" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopKM2*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopKM2" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopKM2 alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopKM2:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopKM2"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopKM2*) queryShopKM2Object:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopKM2"];
    
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
    NSArray *array=[_ShopKM2 queryShopKM2:nil];
    
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

- (NSString*)note {
	[self willAccessValueForKey:@"note"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"note"];
	[self didAccessValueForKey:@"note"];
	return result;
}

- (void)setNote:(NSString*)value {
	[self willChangeValueForKey:@"note"];
	[self setPrimitiveValue:value forKey:@"note"];
	[self didChangeValueForKey:@"note"];
}

- (NSString*)text {
	[self willAccessValueForKey:@"text"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"text"];
	[self didAccessValueForKey:@"text"];
	return result;
}

- (void)setText:(NSString*)value {
	[self willChangeValueForKey:@"text"];
	[self setPrimitiveValue:value forKey:@"text"];
	[self didChangeValueForKey:@"text"];
}

#pragma mark Relationships
    
#pragma mark ListVoucher
- (NSSet*)listVoucher {
	[self willAccessValueForKey:@"listVoucher"];
	NSSet *result = [self primitiveValueForKey:@"listVoucher"];
	[self didAccessValueForKey:@"listVoucher"];
	return result;
}

-(NSArray*) listVoucherObjects
{
    NSSet *set=[self listVoucher];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setListVoucher:(NSSet*)value {
	[self willChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"listVoucher"] setSet:value];
	[self didChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addListVoucher:(NSSet*)value {
	[self willChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"listVoucher"] unionSet:value];
	[self didChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeListVoucher:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"listVoucher"] minusSet:value];
	[self didChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addListVoucherObject:(KM2Voucher*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"listVoucher"] addObject:value];
	[self didChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeListVoucherObject:(KM2Voucher*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"listVoucher"] removeObject:value];
	[self didChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllListVoucher
{
    [self removeListVoucher:self.listVoucher];
}

- (NSMutableSet*)listVoucherSet {
	[self willAccessValueForKey:@"listVoucher"];
	NSMutableSet *result = [self mutableSetValueForKey:@"listVoucher"];
	[self didAccessValueForKey:@"listVoucher"];
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