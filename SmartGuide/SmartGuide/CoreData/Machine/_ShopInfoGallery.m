// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoGallery.m instead.

#import "_ShopInfoGallery.h"
#import "ShopInfoGallery.h"

#import "DataManager.h"
#import "ShopInfo.h"


@implementation _ShopInfoGallery


@dynamic shop;



+(ShopInfoGallery*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopInfoGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopInfoGallery*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopInfoGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopInfoGallery alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopInfoGallery:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfoGallery"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopInfoGallery*) queryShopInfoGalleryObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfoGallery"];
    
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
    NSArray *array=[_ShopInfoGallery queryShopInfoGallery:nil];
    
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

- (NSNumber*)coverHeight {
	[self willAccessValueForKey:@"coverHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"coverHeight"];
	[self didAccessValueForKey:@"coverHeight"];
	return result;
}

- (void)setCoverHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"coverHeight"];
	[self setPrimitiveValue:value forKey:@"coverHeight"];
	[self didChangeValueForKey:@"coverHeight"];
}

- (NSNumber*)coverWidth {
	[self willAccessValueForKey:@"coverWidth"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"coverWidth"];
	[self didAccessValueForKey:@"coverWidth"];
	return result;
}

- (void)setCoverWidth:(NSNumber*)value {
	[self willChangeValueForKey:@"coverWidth"];
	[self setPrimitiveValue:value forKey:@"coverWidth"];
	[self didChangeValueForKey:@"coverWidth"];
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
- (ShopInfo*)shop {
	[self willAccessValueForKey:@"shop"];
	ShopInfo *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
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