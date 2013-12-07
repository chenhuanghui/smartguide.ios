// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopKM1.m instead.

#import "_ShopKM1.h"
#import "ShopKM1.h"

#import "DataManager.h"
#import "KM1Voucher.h"
#import "Shop.h"


@implementation _ShopKM1





@dynamic shop;



+(ShopKM1*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopKM1" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopKM1*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopKM1" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopKM1 alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopKM1:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopKM1"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopKM1 query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(ShopKM1*) queryShopKM1Object:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopKM1"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopKM1 query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_ShopKM1 queryShopKM1:nil];
    
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

- (NSNumber*)idKM1 {
	[self willAccessValueForKey:@"idKM1"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idKM1"];
	[self didAccessValueForKey:@"idKM1"];
	return result;
}

- (void)setIdKM1:(NSNumber*)value {
	[self willChangeValueForKey:@"idKM1"];
	[self setPrimitiveValue:value forKey:@"idKM1"];
	[self didChangeValueForKey:@"idKM1"];
}

- (NSString*)money {
	[self willAccessValueForKey:@"money"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"money"];
	[self didAccessValueForKey:@"money"];
	return result;
}

- (void)setMoney:(NSString*)value {
	[self willChangeValueForKey:@"money"];
	[self setPrimitiveValue:value forKey:@"money"];
	[self didChangeValueForKey:@"money"];
}

- (NSString*)notice {
	[self willAccessValueForKey:@"notice"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"notice"];
	[self didAccessValueForKey:@"notice"];
	return result;
}

- (void)setNotice:(NSString*)value {
	[self willChangeValueForKey:@"notice"];
	[self setPrimitiveValue:value forKey:@"notice"];
	[self didChangeValueForKey:@"notice"];
}

- (NSString*)p {
	[self willAccessValueForKey:@"p"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"p"];
	[self didAccessValueForKey:@"p"];
	return result;
}

- (void)setP:(NSString*)value {
	[self willChangeValueForKey:@"p"];
	[self setPrimitiveValue:value forKey:@"p"];
	[self didChangeValueForKey:@"p"];
}

- (NSString*)sgp {
	[self willAccessValueForKey:@"sgp"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"sgp"];
	[self didAccessValueForKey:@"sgp"];
	return result;
}

- (void)setSgp:(NSString*)value {
	[self willChangeValueForKey:@"sgp"];
	[self setPrimitiveValue:value forKey:@"sgp"];
	[self didChangeValueForKey:@"sgp"];
}

- (NSString*)sp {
	[self willAccessValueForKey:@"sp"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"sp"];
	[self didAccessValueForKey:@"sp"];
	return result;
}

- (void)setSp:(NSString*)value {
	[self willChangeValueForKey:@"sp"];
	[self setPrimitiveValue:value forKey:@"sp"];
	[self didChangeValueForKey:@"sp"];
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
	
- (void)addListVoucherObject:(KM1Voucher*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"listVoucher"] addObject:value];
	[self didChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeListVoucherObject:(KM1Voucher*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"listVoucher"] removeObject:value];
	[self didChangeValueForKey:@"listVoucher" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
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


@end