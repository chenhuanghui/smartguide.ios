// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SearchPlacelist.m instead.

#import "_SearchPlacelist.h"
#import "SearchPlacelist.h"

#import "DataManager.h"


@implementation _SearchPlacelist


+(SearchPlacelist*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"SearchPlacelist" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(SearchPlacelist*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SearchPlacelist" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[SearchPlacelist alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) querySearchPlacelist:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"SearchPlacelist"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(SearchPlacelist*) querySearchPlacelistObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"SearchPlacelist"];
    
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
    NSArray *array=[_SearchPlacelist querySearchPlacelist:nil];
    
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