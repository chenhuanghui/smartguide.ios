// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KM1Voucher.m instead.

#import "_KM1Voucher.h"
#import "KM1Voucher.h"

#import "DataManager.h"
#import "ShopKM1.h"


@implementation _KM1Voucher


@dynamic shopKM1;



+(KM1Voucher*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"KM1Voucher" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(KM1Voucher*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KM1Voucher" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[KM1Voucher alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryKM1Voucher:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"KM1Voucher"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(KM1Voucher*) queryKM1VoucherObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"KM1Voucher"];
    
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
    NSArray *array=[_KM1Voucher queryKM1Voucher:nil];
    
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



- (NSNumber*)idVoucher {
	[self willAccessValueForKey:@"idVoucher"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idVoucher"];
	[self didAccessValueForKey:@"idVoucher"];
	return result;
}

- (void)setIdVoucher:(NSNumber*)value {
	[self willChangeValueForKey:@"idVoucher"];
	[self setPrimitiveValue:value forKey:@"idVoucher"];
	[self didChangeValueForKey:@"idVoucher"];
}

- (NSNumber*)isAfford {
	[self willAccessValueForKey:@"isAfford"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"isAfford"];
	[self didAccessValueForKey:@"isAfford"];
	return result;
}

- (void)setIsAfford:(NSNumber*)value {
	[self willChangeValueForKey:@"isAfford"];
	[self setPrimitiveValue:value forKey:@"isAfford"];
	[self didChangeValueForKey:@"isAfford"];
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

- (NSNumber*)sortOrder {
	[self willAccessValueForKey:@"sortOrder"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"sortOrder"];
	[self didAccessValueForKey:@"sortOrder"];
	return result;
}

- (void)setSortOrder:(NSNumber*)value {
	[self willChangeValueForKey:@"sortOrder"];
	[self setPrimitiveValue:value forKey:@"sortOrder"];
	[self didChangeValueForKey:@"sortOrder"];
}

- (NSString*)type {
	[self willAccessValueForKey:@"type"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"type"];
	[self didAccessValueForKey:@"type"];
	return result;
}

- (void)setType:(NSString*)value {
	[self willChangeValueForKey:@"type"];
	[self setPrimitiveValue:value forKey:@"type"];
	[self didChangeValueForKey:@"type"];
}

#pragma mark Relationships
    
#pragma mark ShopKM1
- (ShopKM1*)shopKM1 {
	[self willAccessValueForKey:@"shopKM1"];
	ShopKM1 *result = [self primitiveValueForKey:@"shopKM1"];
	[self didAccessValueForKey:@"shopKM1"];
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