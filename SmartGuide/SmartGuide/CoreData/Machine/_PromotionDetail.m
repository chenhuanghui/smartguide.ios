// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionDetail.m instead.

#import "_PromotionDetail.h"
#import "PromotionDetail.h"

#import "DataManager.h"
#import "PromotionRequire.h"
#import "Shop.h"
#import "PromotionVoucher.h"


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

- (NSNumber*)min_score {
	[self willAccessValueForKey:@"min_score"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"min_score"];
	[self didAccessValueForKey:@"min_score"];
	return result;
}

- (void)setMin_score:(NSNumber*)value {
	[self willChangeValueForKey:@"min_score"];
	[self setPrimitiveValue:value forKey:@"min_score"];
	[self didChangeValueForKey:@"min_score"];
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

- (NSNumber*)p {
	[self willAccessValueForKey:@"p"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"p"];
	[self didAccessValueForKey:@"p"];
	return result;
}

- (void)setP:(NSNumber*)value {
	[self willChangeValueForKey:@"p"];
	[self setPrimitiveValue:value forKey:@"p"];
	[self didChangeValueForKey:@"p"];
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

#pragma mark Vouchers
- (NSSet*)vouchers {
	[self willAccessValueForKey:@"vouchers"];
	NSSet *result = [self primitiveValueForKey:@"vouchers"];
	[self didAccessValueForKey:@"vouchers"];
	return result;
}

-(NSArray*) vouchersObjects
{
    NSSet *set=[self vouchers];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setVouchers:(NSSet*)value {
	[self willChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"vouchers"] setSet:value];
	[self didChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addVouchers:(NSSet*)value {
	[self willChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"vouchers"] unionSet:value];
	[self didChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeVouchers:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"vouchers"] minusSet:value];
	[self didChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addVouchersObject:(PromotionVoucher*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"vouchers"] addObject:value];
	[self didChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeVouchersObject:(PromotionVoucher*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"vouchers"] removeObject:value];
	[self didChangeValueForKey:@"vouchers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)vouchersSet {
	[self willAccessValueForKey:@"vouchers"];
	NSMutableSet *result = [self mutableSetValueForKey:@"vouchers"];
	[self didAccessValueForKey:@"vouchers"];
	return result;
}


@end