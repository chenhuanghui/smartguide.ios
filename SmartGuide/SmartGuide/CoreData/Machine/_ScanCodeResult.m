// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeResult.m instead.

#import "_ScanCodeResult.h"
#import "ScanCodeResult.h"

#import "DataManager.h"
#import "ScanCodeDecode.h"
#import "ScanCodeRelated.h"


@implementation _ScanCodeResult








+(ScanCodeResult*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ScanCodeResult" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ScanCodeResult*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ScanCodeResult" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ScanCodeResult alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryScanCodeResult:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ScanCodeResult"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ScanCodeResult*) queryScanCodeResultObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ScanCodeResult"];
    
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
    NSArray *array=[_ScanCodeResult queryScanCodeResult:nil];
    
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



- (NSString*)code {
	[self willAccessValueForKey:@"code"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"code"];
	[self didAccessValueForKey:@"code"];
	return result;
}

- (void)setCode:(NSString*)value {
	[self willChangeValueForKey:@"code"];
	[self setPrimitiveValue:value forKey:@"code"];
	[self didChangeValueForKey:@"code"];
}

#pragma mark Relationships
    
#pragma mark Decode
- (NSSet*)decode {
	[self willAccessValueForKey:@"decode"];
	NSSet *result = [self primitiveValueForKey:@"decode"];
	[self didAccessValueForKey:@"decode"];
	return result;
}

-(NSArray*) decodeObjects
{
    NSSet *set=[self decode];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setDecode:(NSSet*)value {
	[self willChangeValueForKey:@"decode" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"decode"] setSet:value];
	[self didChangeValueForKey:@"decode" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addDecode:(NSSet*)value {
	[self willChangeValueForKey:@"decode" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"decode"] unionSet:value];
	[self didChangeValueForKey:@"decode" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeDecode:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"decode" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"decode"] minusSet:value];
	[self didChangeValueForKey:@"decode" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addDecodeObject:(ScanCodeDecode*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"decode" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"decode"] addObject:value];
	[self didChangeValueForKey:@"decode" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeDecodeObject:(ScanCodeDecode*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"decode" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"decode"] removeObject:value];
	[self didChangeValueForKey:@"decode" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllDecode
{
    [self removeDecode:self.decode];
}

- (NSMutableSet*)decodeSet {
	[self willAccessValueForKey:@"decode"];
	NSMutableSet *result = [self mutableSetValueForKey:@"decode"];
	[self didAccessValueForKey:@"decode"];
	return result;
}

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