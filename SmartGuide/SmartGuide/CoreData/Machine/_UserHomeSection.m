// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHomeSection.m instead.

#import "_UserHomeSection.h"
#import "UserHomeSection.h"

#import "DataManager.h"
#import "UserHome.h"
#import "UserHome.h"


@implementation _UserHomeSection





@dynamic home9;



+(UserHomeSection*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserHomeSection" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserHomeSection*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserHomeSection" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserHomeSection alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserHomeSection:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHomeSection"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(UserHomeSection*) queryUserHomeSectionObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHomeSection"];
    
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
    NSArray *array=[_UserHomeSection queryUserHomeSection:nil];
    
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

#pragma mark Relationships
    
#pragma mark Home
- (NSSet*)home {
	[self willAccessValueForKey:@"home"];
	NSSet *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
	return result;
}

-(NSArray*) homeObjects
{
    NSSet *set=[self home];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setHome:(NSSet*)value {
	[self willChangeValueForKey:@"home" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home"] setSet:value];
	[self didChangeValueForKey:@"home" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addHome:(NSSet*)value {
	[self willChangeValueForKey:@"home" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home"] unionSet:value];
	[self didChangeValueForKey:@"home" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeHome:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"home" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home"] minusSet:value];
	[self didChangeValueForKey:@"home" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addHomeObject:(UserHome*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home"] addObject:value];
	[self didChangeValueForKey:@"home" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeHomeObject:(UserHome*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home"] removeObject:value];
	[self didChangeValueForKey:@"home" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllHome
{
    [self removeHome:self.home];
}

- (NSMutableSet*)homeSet {
	[self willAccessValueForKey:@"home"];
	NSMutableSet *result = [self mutableSetValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
	return result;
}

#pragma mark Home9
- (UserHome*)home9 {
	[self willAccessValueForKey:@"home9"];
	UserHome *result = [self primitiveValueForKey:@"home9"];
	[self didAccessValueForKey:@"home9"];
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