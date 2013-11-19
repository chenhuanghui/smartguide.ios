// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionRequire.m instead.

#import "_PromotionRequire.h"
#import "PromotionRequire.h"

#import "DataManager.h"
#import "PromotionDetail.h"


@implementation _PromotionRequire


@dynamic promotion;



+(PromotionRequire*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"PromotionRequire" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(PromotionRequire*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PromotionRequire" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[PromotionRequire alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryPromotionRequire:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PromotionRequire"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"PromotionRequire query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(PromotionRequire*) queryPromotionRequireObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PromotionRequire"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"PromotionRequire query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_PromotionRequire queryPromotionRequire:nil];
    
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
        NSLog(@"PromotionRequire save error %@",error);
        
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

- (NSNumber*)idRequire {
	[self willAccessValueForKey:@"idRequire"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idRequire"];
	[self didAccessValueForKey:@"idRequire"];
	return result;
}

- (void)setIdRequire:(NSNumber*)value {
	[self willChangeValueForKey:@"idRequire"];
	[self setPrimitiveValue:value forKey:@"idRequire"];
	[self didChangeValueForKey:@"idRequire"];
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

- (NSNumber*)sgpRequired {
	[self willAccessValueForKey:@"sgpRequired"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"sgpRequired"];
	[self didAccessValueForKey:@"sgpRequired"];
	return result;
}

- (void)setSgpRequired:(NSNumber*)value {
	[self willChangeValueForKey:@"sgpRequired"];
	[self setPrimitiveValue:value forKey:@"sgpRequired"];
	[self didChangeValueForKey:@"sgpRequired"];
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