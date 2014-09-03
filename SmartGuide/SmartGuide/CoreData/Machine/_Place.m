// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Place.m instead.

#import "_Place.h"
#import "Place.h"

#import "DataManager.h"
#import "ShopInfoList.h"


@implementation _Place





+(Place*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Place*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Place alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryPlace:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(Place*) queryPlaceObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    
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
    NSArray *array=[_Place queryPlace:nil];
    
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



- (NSString*)authorAvatar {
	[self willAccessValueForKey:@"authorAvatar"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"authorAvatar"];
	[self didAccessValueForKey:@"authorAvatar"];
	return result;
}

- (void)setAuthorAvatar:(NSString*)value {
	[self willChangeValueForKey:@"authorAvatar"];
	[self setPrimitiveValue:value forKey:@"authorAvatar"];
	[self didChangeValueForKey:@"authorAvatar"];
}

- (NSString*)authorName {
	[self willAccessValueForKey:@"authorName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"authorName"];
	[self didAccessValueForKey:@"authorName"];
	return result;
}

- (void)setAuthorName:(NSString*)value {
	[self willChangeValueForKey:@"authorName"];
	[self setPrimitiveValue:value forKey:@"authorName"];
	[self didChangeValueForKey:@"authorName"];
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

- (NSNumber*)idAuthor {
	[self willAccessValueForKey:@"idAuthor"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idAuthor"];
	[self didAccessValueForKey:@"idAuthor"];
	return result;
}

- (void)setIdAuthor:(NSNumber*)value {
	[self willChangeValueForKey:@"idAuthor"];
	[self setPrimitiveValue:value forKey:@"idAuthor"];
	[self didChangeValueForKey:@"idAuthor"];
}

- (NSNumber*)idPlace {
	[self willAccessValueForKey:@"idPlace"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idPlace"];
	[self didAccessValueForKey:@"idPlace"];
	return result;
}

- (void)setIdPlace:(NSNumber*)value {
	[self willChangeValueForKey:@"idPlace"];
	[self setPrimitiveValue:value forKey:@"idPlace"];
	[self didChangeValueForKey:@"idPlace"];
}

- (NSString*)image {
	[self willAccessValueForKey:@"image"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"image"];
	[self didAccessValueForKey:@"image"];
	return result;
}

- (void)setImage:(NSString*)value {
	[self willChangeValueForKey:@"image"];
	[self setPrimitiveValue:value forKey:@"image"];
	[self didChangeValueForKey:@"image"];
}

- (NSNumber*)loveStatus {
	[self willAccessValueForKey:@"loveStatus"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"loveStatus"];
	[self didAccessValueForKey:@"loveStatus"];
	return result;
}

- (void)setLoveStatus:(NSNumber*)value {
	[self willChangeValueForKey:@"loveStatus"];
	[self setPrimitiveValue:value forKey:@"loveStatus"];
	[self didChangeValueForKey:@"loveStatus"];
}

- (NSString*)numOfView {
	[self willAccessValueForKey:@"numOfView"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numOfView"];
	[self didAccessValueForKey:@"numOfView"];
	return result;
}

- (void)setNumOfView:(NSString*)value {
	[self willChangeValueForKey:@"numOfView"];
	[self setPrimitiveValue:value forKey:@"numOfView"];
	[self didChangeValueForKey:@"numOfView"];
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
    
#pragma mark Shops
- (NSSet*)shops {
	[self willAccessValueForKey:@"shops"];
	NSSet *result = [self primitiveValueForKey:@"shops"];
	[self didAccessValueForKey:@"shops"];
	return result;
}

-(NSArray*) shopsObjects
{
    NSSet *set=[self shops];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setShops:(NSSet*)value {
	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shops"] setSet:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addShops:(NSSet*)value {
	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shops"] unionSet:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeShops:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shops"] minusSet:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addShopsObject:(ShopInfoList*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shops"] addObject:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeShopsObject:(ShopInfoList*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shops" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shops"] removeObject:value];
	[self didChangeValueForKey:@"shops" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllShops
{
    [self removeShops:self.shops];
}

- (NSMutableSet*)shopsSet {
	[self willAccessValueForKey:@"shops"];
	NSMutableSet *result = [self mutableSetValueForKey:@"shops"];
	[self didAccessValueForKey:@"shops"];
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