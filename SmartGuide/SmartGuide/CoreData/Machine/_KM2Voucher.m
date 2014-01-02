// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KM2Voucher.m instead.

#import "_KM2Voucher.h"
#import "KM2Voucher.h"

#import "DataManager.h"
#import "ShopKM2.h"


@implementation _KM2Voucher


@dynamic shopKM2;



+(KM2Voucher*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"KM2Voucher" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(KM2Voucher*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KM2Voucher" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[KM2Voucher alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryKM2Voucher:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"KM2Voucher"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"KM2Voucher query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(KM2Voucher*) queryKM2VoucherObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"KM2Voucher"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"KM2Voucher query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_KM2Voucher queryKM2Voucher:nil];
    
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



- (NSString*)condition {
	[self willAccessValueForKey:@"condition"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"condition"];
	[self didAccessValueForKey:@"condition"];
	return result;
}

- (void)setCondition:(NSString*)value {
	[self willChangeValueForKey:@"condition"];
	[self setPrimitiveValue:value forKey:@"condition"];
	[self didChangeValueForKey:@"condition"];
}

- (NSString*)highlightKeywords {
	[self willAccessValueForKey:@"highlightKeywords"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"highlightKeywords"];
	[self didAccessValueForKey:@"highlightKeywords"];
	return result;
}

- (void)setHighlightKeywords:(NSString*)value {
	[self willChangeValueForKey:@"highlightKeywords"];
	[self setPrimitiveValue:value forKey:@"highlightKeywords"];
	[self didChangeValueForKey:@"highlightKeywords"];
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
    
#pragma mark ShopKM2
- (ShopKM2*)shopKM2 {
	[self willAccessValueForKey:@"shopKM2"];
	ShopKM2 *result = [self primitiveValueForKey:@"shopKM2"];
	[self didAccessValueForKey:@"shopKM2"];
	return result;
}


@end