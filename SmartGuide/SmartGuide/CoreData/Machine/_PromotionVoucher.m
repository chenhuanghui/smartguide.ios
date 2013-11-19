// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionVoucher.m instead.

#import "_PromotionVoucher.h"
#import "PromotionVoucher.h"

#import "DataManager.h"
#import "PromotionDetail.h"


@implementation _PromotionVoucher


@dynamic promotion;



+(PromotionVoucher*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"PromotionVoucher" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(PromotionVoucher*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PromotionVoucher" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[PromotionVoucher alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryPromotionVoucher:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PromotionVoucher"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"PromotionVoucher query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(PromotionVoucher*) queryPromotionVoucherObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PromotionVoucher"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"PromotionVoucher query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_PromotionVoucher queryPromotionVoucher:nil];
    
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
        NSLog(@"PromotionVoucher save error %@",error);
        
    return result;
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

- (NSNumber*)money {
	[self willAccessValueForKey:@"money"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"money"];
	[self didAccessValueForKey:@"money"];
	return result;
}

- (void)setMoney:(NSNumber*)value {
	[self willChangeValueForKey:@"money"];
	[self setPrimitiveValue:value forKey:@"money"];
	[self didChangeValueForKey:@"money"];
}

- (NSString*)numberVoucher {
	[self willAccessValueForKey:@"numberVoucher"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numberVoucher"];
	[self didAccessValueForKey:@"numberVoucher"];
	return result;
}

- (void)setNumberVoucher:(NSString*)value {
	[self willChangeValueForKey:@"numberVoucher"];
	[self setPrimitiveValue:value forKey:@"numberVoucher"];
	[self didChangeValueForKey:@"numberVoucher"];
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

#pragma mark Relationships
    
#pragma mark Promotion
- (PromotionDetail*)promotion {
	[self willAccessValueForKey:@"promotion"];
	PromotionDetail *result = [self primitiveValueForKey:@"promotion"];
	[self didAccessValueForKey:@"promotion"];
	return result;
}


@end