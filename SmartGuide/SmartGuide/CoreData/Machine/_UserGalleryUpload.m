// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserGalleryUpload.m instead.

#import "_UserGalleryUpload.h"
#import "UserGalleryUpload.h"

#import "DataManager.h"


@implementation _UserGalleryUpload


+(UserGalleryUpload*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserGalleryUpload" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserGalleryUpload*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserGalleryUpload" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserGalleryUpload alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserGalleryUpload:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserGalleryUpload"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(UserGalleryUpload*) queryUserGalleryUploadObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserGalleryUpload"];
    
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
    NSArray *array=[_UserGalleryUpload queryUserGalleryUpload:nil];
    
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

- (NSNumber*)idShop {
	[self willAccessValueForKey:@"idShop"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idShop"];
	[self didAccessValueForKey:@"idShop"];
	return result;
}

- (void)setIdShop:(NSNumber*)value {
	[self willChangeValueForKey:@"idShop"];
	[self setPrimitiveValue:value forKey:@"idShop"];
	[self didChangeValueForKey:@"idShop"];
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

- (NSData*)image {
	[self willAccessValueForKey:@"image"];
	NSData* result = (NSData*)[self primitiveValueForKey:@"image"];
	[self didAccessValueForKey:@"image"];
	return result;
}

- (void)setImage:(NSData*)value {
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

- (NSNumber*)status {
	[self willAccessValueForKey:@"status"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"status"];
	[self didAccessValueForKey:@"status"];
	return result;
}

- (void)setStatus:(NSNumber*)value {
	[self willChangeValueForKey:@"status"];
	[self setPrimitiveValue:value forKey:@"status"];
	[self didChangeValueForKey:@"status"];
}

- (NSNumber*)userLat {
	[self willAccessValueForKey:@"userLat"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"userLat"];
	[self didAccessValueForKey:@"userLat"];
	return result;
}

- (void)setUserLat:(NSNumber*)value {
	[self willChangeValueForKey:@"userLat"];
	[self setPrimitiveValue:value forKey:@"userLat"];
	[self didChangeValueForKey:@"userLat"];
}

- (NSNumber*)userLng {
	[self willAccessValueForKey:@"userLng"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"userLng"];
	[self didAccessValueForKey:@"userLng"];
	return result;
}

- (void)setUserLng:(NSNumber*)value {
	[self willChangeValueForKey:@"userLng"];
	[self setPrimitiveValue:value forKey:@"userLng"];
	[self didChangeValueForKey:@"userLng"];
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