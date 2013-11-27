// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopUserGallery.m instead.

#import "_ShopUserGallery.h"
#import "ShopUserGallery.h"

#import "DataManager.h"
#import "Shop.h"


@implementation _ShopUserGallery


@dynamic shop;



+(ShopUserGallery*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopUserGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopUserGallery*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopUserGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopUserGallery alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopUserGallery:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopUserGallery"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopUserGallery query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(ShopUserGallery*) queryShopUserGalleryObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopUserGallery"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopUserGallery query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_ShopUserGallery queryShopUserGallery:nil];
    
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

- (NSString*)thumbnail {
	[self willAccessValueForKey:@"thumbnail"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"thumbnail"];
	[self didAccessValueForKey:@"thumbnail"];
	return result;
}

- (void)setThumbnail:(NSString*)value {
	[self willChangeValueForKey:@"thumbnail"];
	[self setPrimitiveValue:value forKey:@"thumbnail"];
	[self didChangeValueForKey:@"thumbnail"];
}

- (NSString*)time {
	[self willAccessValueForKey:@"time"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"time"];
	[self didAccessValueForKey:@"time"];
	return result;
}

- (void)setTime:(NSString*)value {
	[self willChangeValueForKey:@"time"];
	[self setPrimitiveValue:value forKey:@"time"];
	[self didChangeValueForKey:@"time"];
}

- (NSString*)username {
	[self willAccessValueForKey:@"username"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"username"];
	[self didAccessValueForKey:@"username"];
	return result;
}

- (void)setUsername:(NSString*)value {
	[self willChangeValueForKey:@"username"];
	[self setPrimitiveValue:value forKey:@"username"];
	[self didChangeValueForKey:@"username"];
}

#pragma mark Relationships
    
#pragma mark Shop
- (Shop*)shop {
	[self willAccessValueForKey:@"shop"];
	Shop *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
	return result;
}


@end