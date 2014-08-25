// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HomeImages.m instead.

#import "_HomeImages.h"
#import "HomeImages.h"

#import "DataManager.h"
#import "Home.h"
#import "HomeImage.h"


@implementation _HomeImages


@dynamic home;






+(HomeImages*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"HomeImages" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(HomeImages*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HomeImages" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[HomeImages alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryHomeImages:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HomeImages"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(HomeImages*) queryHomeImagesObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HomeImages"];
    
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
    NSArray *array=[_HomeImages queryHomeImages:nil];
    
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

#pragma mark Relationships
    
#pragma mark Home
- (Home*)home {
	[self willAccessValueForKey:@"home"];
	Home *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
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
	
- (void)addImagesObject:(HomeImage*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"images"] addObject:value];
	[self didChangeValueForKey:@"images" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeImagesObject:(HomeImage*)value {

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
    [self.managedObjectContext refreshObject:self mergeChanges:false];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end