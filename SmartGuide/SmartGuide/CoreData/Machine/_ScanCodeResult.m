// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeResult.m instead.

#import "_ScanCodeResult.h"
#import "ScanCodeResult.h"

#import "DataManager.h"
#import "ScanCodeDecode.h"
#import "ScanCodeRelatedContain.h"


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

- (NSNumber*)decodeType {
	[self willAccessValueForKey:@"decodeType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"decodeType"];
	[self didAccessValueForKey:@"decodeType"];
	return result;
}

- (void)setDecodeType:(NSNumber*)value {
	[self willChangeValueForKey:@"decodeType"];
	[self setPrimitiveValue:value forKey:@"decodeType"];
	[self didChangeValueForKey:@"decodeType"];
}

- (NSNumber*)relatedStatus {
	[self willAccessValueForKey:@"relatedStatus"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"relatedStatus"];
	[self didAccessValueForKey:@"relatedStatus"];
	return result;
}

- (void)setRelatedStatus:(NSNumber*)value {
	[self willChangeValueForKey:@"relatedStatus"];
	[self setPrimitiveValue:value forKey:@"relatedStatus"];
	[self didChangeValueForKey:@"relatedStatus"];
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

#pragma mark RelatedContain
- (NSSet*)relatedContain {
	[self willAccessValueForKey:@"relatedContain"];
	NSSet *result = [self primitiveValueForKey:@"relatedContain"];
	[self didAccessValueForKey:@"relatedContain"];
	return result;
}

-(NSArray*) relatedContainObjects
{
    NSSet *set=[self relatedContain];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setRelatedContain:(NSSet*)value {
	[self willChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"relatedContain"] setSet:value];
	[self didChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addRelatedContain:(NSSet*)value {
	[self willChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"relatedContain"] unionSet:value];
	[self didChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeRelatedContain:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"relatedContain"] minusSet:value];
	[self didChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addRelatedContainObject:(ScanCodeRelatedContain*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"relatedContain"] addObject:value];
	[self didChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeRelatedContainObject:(ScanCodeRelatedContain*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"relatedContain"] removeObject:value];
	[self didChangeValueForKey:@"relatedContain" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllRelatedContain
{
    [self removeRelatedContain:self.relatedContain];
}

- (NSMutableSet*)relatedContainSet {
	[self willAccessValueForKey:@"relatedContain"];
	NSMutableSet *result = [self mutableSetValueForKey:@"relatedContain"];
	[self didAccessValueForKey:@"relatedContain"];
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