// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome.m instead.

#import "_UserHome.h"
#import "UserHome.h"

#import "DataManager.h"
#import "UserHome1.h"
#import "UserHome2.h"
#import "UserHome3.h"
#import "UserHome4.h"
#import "UserHome6.h"
#import "UserHome8.h"
#import "UserHomeImage.h"


@implementation _UserHome


@dynamic home1;












@dynamic home6;



@dynamic home8;






+(UserHome*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserHome" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserHome*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserHome" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserHome alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserHome:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(UserHome*) queryUserHomeObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome"];
    
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
    NSArray *array=[_UserHome queryUserHome:nil];
    
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

- (NSNumber*)idPost {
	[self willAccessValueForKey:@"idPost"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idPost"];
	[self didAccessValueForKey:@"idPost"];
	return result;
}

- (void)setIdPost:(NSNumber*)value {
	[self willChangeValueForKey:@"idPost"];
	[self setPrimitiveValue:value forKey:@"idPost"];
	[self didChangeValueForKey:@"idPost"];
}

- (NSString*)idShops {
	[self willAccessValueForKey:@"idShops"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"idShops"];
	[self didAccessValueForKey:@"idShops"];
	return result;
}

- (void)setIdShops:(NSString*)value {
	[self willChangeValueForKey:@"idShops"];
	[self setPrimitiveValue:value forKey:@"idShops"];
	[self didChangeValueForKey:@"idShops"];
}

- (NSNumber*)imageHeight {
	[self willAccessValueForKey:@"imageHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"imageHeight"];
	[self didAccessValueForKey:@"imageHeight"];
	return result;
}

- (void)setImageHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"imageHeight"];
	[self setPrimitiveValue:value forKey:@"imageHeight"];
	[self didChangeValueForKey:@"imageHeight"];
}

- (NSNumber*)imageWidth {
	[self willAccessValueForKey:@"imageWidth"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"imageWidth"];
	[self didAccessValueForKey:@"imageWidth"];
	return result;
}

- (void)setImageWidth:(NSNumber*)value {
	[self willChangeValueForKey:@"imageWidth"];
	[self setPrimitiveValue:value forKey:@"imageWidth"];
	[self didChangeValueForKey:@"imageWidth"];
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
    
#pragma mark Home1
- (UserHome1*)home1 {
	[self willAccessValueForKey:@"home1"];
	UserHome1 *result = [self primitiveValueForKey:@"home1"];
	[self didAccessValueForKey:@"home1"];
	return result;
}

#pragma mark Home2
- (NSSet*)home2 {
	[self willAccessValueForKey:@"home2"];
	NSSet *result = [self primitiveValueForKey:@"home2"];
	[self didAccessValueForKey:@"home2"];
	return result;
}

-(NSArray*) home2Objects
{
    NSSet *set=[self home2];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setHome2:(NSSet*)value {
	[self willChangeValueForKey:@"home2" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home2"] setSet:value];
	[self didChangeValueForKey:@"home2" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addHome2:(NSSet*)value {
	[self willChangeValueForKey:@"home2" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home2"] unionSet:value];
	[self didChangeValueForKey:@"home2" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeHome2:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"home2" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home2"] minusSet:value];
	[self didChangeValueForKey:@"home2" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addHome2Object:(UserHome2*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home2" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home2"] addObject:value];
	[self didChangeValueForKey:@"home2" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeHome2Object:(UserHome2*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home2" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home2"] removeObject:value];
	[self didChangeValueForKey:@"home2" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllHome2
{
    [self removeHome2:self.home2];
}

- (NSMutableSet*)home2Set {
	[self willAccessValueForKey:@"home2"];
	NSMutableSet *result = [self mutableSetValueForKey:@"home2"];
	[self didAccessValueForKey:@"home2"];
	return result;
}

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

#pragma mark Home4
- (NSSet*)home4 {
	[self willAccessValueForKey:@"home4"];
	NSSet *result = [self primitiveValueForKey:@"home4"];
	[self didAccessValueForKey:@"home4"];
	return result;
}

-(NSArray*) home4Objects
{
    NSSet *set=[self home4];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setHome4:(NSSet*)value {
	[self willChangeValueForKey:@"home4" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home4"] setSet:value];
	[self didChangeValueForKey:@"home4" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addHome4:(NSSet*)value {
	[self willChangeValueForKey:@"home4" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home4"] unionSet:value];
	[self didChangeValueForKey:@"home4" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeHome4:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"home4" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home4"] minusSet:value];
	[self didChangeValueForKey:@"home4" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addHome4Object:(UserHome4*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home4" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home4"] addObject:value];
	[self didChangeValueForKey:@"home4" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeHome4Object:(UserHome4*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home4" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home4"] removeObject:value];
	[self didChangeValueForKey:@"home4" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllHome4
{
    [self removeHome4:self.home4];
}

- (NSMutableSet*)home4Set {
	[self willAccessValueForKey:@"home4"];
	NSMutableSet *result = [self mutableSetValueForKey:@"home4"];
	[self didAccessValueForKey:@"home4"];
	return result;
}

#pragma mark Home6
- (UserHome6*)home6 {
	[self willAccessValueForKey:@"home6"];
	UserHome6 *result = [self primitiveValueForKey:@"home6"];
	[self didAccessValueForKey:@"home6"];
	return result;
}

#pragma mark Home8
- (UserHome8*)home8 {
	[self willAccessValueForKey:@"home8"];
	UserHome8 *result = [self primitiveValueForKey:@"home8"];
	[self didAccessValueForKey:@"home8"];
	return result;
}

#pragma mark Images
- (NSSet*)images {
	[self willAccessValueForKey:@"images"];
	NSSet *result = [self primitiveValueForKey:@"images"];
	[self didAccessValueForKey:@"images"];
	return result;
}

-(NSArray*) imagesObjects
{
    NSSet *set=[self images];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setImages:(NSSet*)value {
	[self willChangeValueForKey:@"images" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"images"] setSet:value];
	[self didChangeValueForKey:@"images" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addImages:(NSSet*)value {
	[self willChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"images"] unionSet:value];
	[self didChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeImages:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"images" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"images"] minusSet:value];
	[self didChangeValueForKey:@"images" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addImagesObject:(UserHomeImage*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"images"] addObject:value];
	[self didChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeImagesObject:(UserHomeImage*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"images" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"images"] removeObject:value];
	[self didChangeValueForKey:@"images" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllImages
{
    [self removeImages:self.images];
}

- (NSMutableSet*)imagesSet {
	[self willAccessValueForKey:@"images"];
	NSMutableSet *result = [self mutableSetValueForKey:@"images"];
	[self didAccessValueForKey:@"images"];
	return result;
}


#pragma mark Utility

-(void) revert
{
    [[[DataManager shareInstance] managedObjectContext] refreshObject:self mergeChanges:false];
}

-(void) save
{
    [[DataManager shareInstance] save];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end