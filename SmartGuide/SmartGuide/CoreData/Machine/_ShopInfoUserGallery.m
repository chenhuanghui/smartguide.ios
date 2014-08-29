// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoUserGallery.m instead.

#import "_ShopInfoUserGallery.h"
#import "ShopInfoUserGallery.h"

#import "DataManager.h"
#import "ShopInfo.h"


@implementation _ShopInfoUserGallery


@dynamic shop;



+(ShopInfoUserGallery*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopInfoUserGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopInfoUserGallery*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopInfoUserGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopInfoUserGallery alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopInfoUserGallery:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfoUserGallery"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopInfoUserGallery*) queryShopInfoUserGalleryObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfoUserGallery"];
    
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
    NSArray *array=[_ShopInfoUserGallery queryShopInfoUserGallery:nil];
    
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

- (NSNumber*)idUserGallery {
	[self willAccessValueForKey:@"idUserGallery"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idUserGallery"];
	[self didAccessValueForKey:@"idUserGallery"];
	return result;
}

- (void)setIdUserGallery:(NSNumber*)value {
	[self willChangeValueForKey:@"idUserGallery"];
	[self setPrimitiveValue:value forKey:@"idUserGallery"];
	[self didChangeValueForKey:@"idUserGallery"];
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