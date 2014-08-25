// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Placelist.m instead.

#import "_Placelist.h"
#import "Placelist.h"

#import "DataManager.h"
#import "UserHome3.h"
#import "ShopList.h"


@implementation _Placelist








+(Placelist*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Placelist" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Placelist*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Placelist" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Placelist alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryPlacelist:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Placelist"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(Placelist*) queryPlacelistObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Placelist"];
    
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
    NSArray *array=[_Placelist queryPlacelist:nil];
    
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

- (NSNumber*)idPlacelist {
	[self willAccessValueForKey:@"idPlacelist"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idPlacelist"];
	[self didAccessValueForKey:@"idPlacelist"];
	return result;
}

- (void)setIdPlacelist:(NSNumber*)value {
	[self willChangeValueForKey:@"idPlacelist"];
	[self setPrimitiveValue:value forKey:@"idPlacelist"];
	[self didChangeValueForKey:@"idPlacelist"];
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
    
#pragma mark Home3
- (NSSet*)home3 {
	[self willAccessValueForKey:@"home3"];
	NSSet *result = [self primitiveValueForKey:@"home3"];
	[self didAccessValueForKey:@"home3"];
	return result;
}

-(NSArray*) home3Objects
{
    NSSet *set=[self home3];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setHome3:(NSSet*)value {
	[self willChangeValueForKey:@"home3" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home3"] setSet:value];
	[self didChangeValueForKey:@"home3" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addHome3:(NSSet*)value {
	[self willChangeValueForKey:@"home3" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home3"] unionSet:value];
	[self didChangeValueForKey:@"home3" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeHome3:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"home3" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home3"] minusSet:value];
	[self didChangeValueForKey:@"home3" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addHome3Object:(UserHome3*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home3" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home3"] addObject:value];
	[self didChangeValueForKey:@"home3" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeHome3Object:(UserHome3*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home3" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home3"] removeObject:value];
	[self didChangeValueForKey:@"home3" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllHome3
{
    [self removeHome3:self.home3];
}

- (NSMutableSet*)home3Set {
	[self willAccessValueForKey:@"home3"];
	NSMutableSet *result = [self mutableSetValueForKey:@"home3"];
	[self didAccessValueForKey:@"home3"];
	return result;
}

#pragma mark ShopsList
- (NSSet*)shopsList {
	[self willAccessValueForKey:@"shopsList"];
	NSSet *result = [self primitiveValueForKey:@"shopsList"];
	[self didAccessValueForKey:@"shopsList"];
	return result;
}

-(NSArray*) shopsListObjects
{
    NSSet *set=[self shopsList];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setShopsList:(NSSet*)value {
	[self willChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopsList"] setSet:value];
	[self didChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addShopsList:(NSSet*)value {
	[self willChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopsList"] unionSet:value];
	[self didChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeShopsList:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopsList"] minusSet:value];
	[self didChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addShopsListObject:(ShopList*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopsList"] addObject:value];
	[self didChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeShopsListObject:(ShopList*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopsList"] removeObject:value];
	[self didChangeValueForKey:@"shopsList" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllShopsList
{
    [self removeShopsList:self.shopsList];
}

- (NSMutableSet*)shopsListSet {
	[self willAccessValueForKey:@"shopsList"];
	NSMutableSet *result = [self mutableSetValueForKey:@"shopsList"];
	[self didAccessValueForKey:@"shopsList"];
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