// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopGallery.m instead.

#import "_ShopGallery.h"
#import "ShopGallery.h"

#import "DataManager.h"
#import "Shop.h"


@implementation _ShopGallery


@dynamic shop;



+(ShopGallery*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopGallery*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopGallery alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopGallery:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopGallery"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopGallery*) queryShopGalleryObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopGallery"];
    
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
    NSArray *array=[_ShopGallery queryShopGallery:nil];
    
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



- (NSString*)cover {
	[self willAccessValueForKey:@"cover"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"cover"];
	[self didAccessValueForKey:@"cover"];
	return result;
}

- (void)setCover:(NSString*)value {
	[self willChangeValueForKey:@"cover"];
	[self setPrimitiveValue:value forKey:@"cover"];
	[self didChangeValueForKey:@"cover"];
}

- (NSNumber*)idGallery {
	[self willAccessValueForKey:@"idGallery"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idGallery"];
	[self didAccessValueForKey:@"idGallery"];
	return result;
}

- (void)setIdGallery:(NSNumber*)value {
	[self willChangeValueForKey:@"idGallery"];
	[self setPrimitiveValue:value forKey:@"idGallery"];
	[self didChangeValueForKey:@"idGallery"];
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

#pragma mark Relationships
    
#pragma mark Shop
- (Shop*)shop {
	[self willAccessValueForKey:@"shop"];
	Shop *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
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