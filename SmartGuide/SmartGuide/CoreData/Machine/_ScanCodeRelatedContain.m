// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeRelatedContain.m instead.

#import "_ScanCodeRelatedContain.h"
#import "ScanCodeRelatedContain.h"

#import "DataManager.h"
#import "ScanCodeRelated.h"
#import "ScanCodeResult.h"


@implementation _ScanCodeRelatedContain





@dynamic result;



+(ScanCodeRelatedContain*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ScanCodeRelatedContain" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ScanCodeRelatedContain*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ScanCodeRelatedContain" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ScanCodeRelatedContain alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryScanCodeRelatedContain:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ScanCodeRelatedContain"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ScanCodeRelatedContain*) queryScanCodeRelatedContainObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ScanCodeRelatedContain"];
    
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
    NSArray *array=[_ScanCodeRelatedContain queryScanCodeRelatedContain:nil];
    
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



- (NSNumber*)canLoadMore {
	[self willAccessValueForKey:@"canLoadMore"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"canLoadMore"];
	[self didAccessValueForKey:@"canLoadMore"];
	return result;
}

- (void)setCanLoadMore:(NSNumber*)value {
	[self willChangeValueForKey:@"canLoadMore"];
	[self setPrimitiveValue:value forKey:@"canLoadMore"];
	[self didChangeValueForKey:@"canLoadMore"];
}

- (NSNumber*)isLoadingMore {
	[self willAccessValueForKey:@"isLoadingMore"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"isLoadingMore"];
	[self didAccessValueForKey:@"isLoadingMore"];
	return result;
}

- (void)setIsLoadingMore:(NSNumber*)value {
	[self willChangeValueForKey:@"isLoadingMore"];
	[self setPrimitiveValue:value forKey:@"isLoadingMore"];
	[self didChangeValueForKey:@"isLoadingMore"];
}

- (NSNumber*)order {
	[self willAccessValueForKey:@"order"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"order"];
	[self didAccessValueForKey:@"order"];
	return result;
}

- (void)setOrder:(NSNumber*)value {
	[self willChangeValueForKey:@"order"];
	[self setPrimitiveValue:value forKey:@"order"];
	[self didChangeValueForKey:@"order"];
}

- (NSNumber*)page {
	[self willAccessValueForKey:@"page"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"page"];
	[self didAccessValueForKey:@"page"];
	return result;
}

- (void)setPage:(NSNumber*)value {
	[self willChangeValueForKey:@"page"];
	[self setPrimitiveValue:value forKey:@"page"];
	[self didChangeValueForKey:@"page"];
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
    
#pragma mark Relaties
- (NSSet*)relaties {
	[self willAccessValueForKey:@"relaties"];
	NSSet *result = [self primitiveValueForKey:@"relaties"];
	[self didAccessValueForKey:@"relaties"];
	return result;
}

-(NSArray*) relatiesObjects
{
    NSSet *set=[self relaties];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setRelaties:(NSSet*)value {
	[self willChangeValueForKey:@"relaties" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"relaties"] setSet:value];
	[self didChangeValueForKey:@"relaties" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addRelaties:(NSSet*)value {
	[self willChangeValueForKey:@"relaties" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"relaties"] unionSet:value];
	[self didChangeValueForKey:@"relaties" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeRelaties:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"relaties" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"relaties"] minusSet:value];
	[self didChangeValueForKey:@"relaties" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addRelatiesObject:(ScanCodeRelated*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"relaties" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"relaties"] addObject:value];
	[self didChangeValueForKey:@"relaties" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeRelatiesObject:(ScanCodeRelated*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"relaties" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"relaties"] removeObject:value];
	[self didChangeValueForKey:@"relaties" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllRelaties
{
    [self removeRelaties:self.relaties];
}

- (NSMutableSet*)relatiesSet {
	[self willAccessValueForKey:@"relaties"];
	NSMutableSet *result = [self mutableSetValueForKey:@"relaties"];
	[self didAccessValueForKey:@"relaties"];
	return result;
}

#pragma mark Result
- (ScanCodeResult*)result {
	[self willAccessValueForKey:@"result"];
	ScanCodeResult *result = [self primitiveValueForKey:@"result"];
	[self didAccessValueForKey:@"result"];
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