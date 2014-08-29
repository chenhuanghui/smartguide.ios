// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoEvent.m instead.

#import "_ShopInfoEvent.h"
#import "ShopInfoEvent.h"

#import "DataManager.h"
#import "ShopInfo.h"


@implementation _ShopInfoEvent


@dynamic shop;



+(ShopInfoEvent*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopInfoEvent" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopInfoEvent*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopInfoEvent" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopInfoEvent alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopInfoEvent:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfoEvent"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopInfoEvent*) queryShopInfoEventObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfoEvent"];
    
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
    NSArray *array=[_ShopInfoEvent queryShopInfoEvent:nil];
    
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



- (NSString*)content {
	[self willAccessValueForKey:@"content"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"content"];
	[self didAccessValueForKey:@"content"];
	return result;
}

- (void)setContent:(NSString*)value {
	[self willChangeValueForKey:@"content"];
	[self setPrimitiveValue:value forKey:@"content"];
	[self didChangeValueForKey:@"content"];
}

- (NSString*)duration {
	[self willAccessValueForKey:@"duration"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"duration"];
	[self didAccessValueForKey:@"duration"];
	return result;
}

- (void)setDuration:(NSString*)value {
	[self willChangeValueForKey:@"duration"];
	[self setPrimitiveValue:value forKey:@"duration"];
	[self didChangeValueForKey:@"duration"];
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

- (NSString*)video {
	[self willAccessValueForKey:@"video"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"video"];
	[self didAccessValueForKey:@"video"];
	return result;
}

- (void)setVideo:(NSString*)value {
	[self willChangeValueForKey:@"video"];
	[self setPrimitiveValue:value forKey:@"video"];
	[self didChangeValueForKey:@"video"];
}

- (NSNumber*)videoHeight {
	[self willAccessValueForKey:@"videoHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"videoHeight"];
	[self didAccessValueForKey:@"videoHeight"];
	return result;
}

- (void)setVideoHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"videoHeight"];
	[self setPrimitiveValue:value forKey:@"videoHeight"];
	[self didChangeValueForKey:@"videoHeight"];
}

- (NSString*)videoThumbnail {
	[self willAccessValueForKey:@"videoThumbnail"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"videoThumbnail"];
	[self didAccessValueForKey:@"videoThumbnail"];
	return result;
}

- (void)setVideoThumbnail:(NSString*)value {
	[self willChangeValueForKey:@"videoThumbnail"];
	[self setPrimitiveValue:value forKey:@"videoThumbnail"];
	[self didChangeValueForKey:@"videoThumbnail"];
}

- (NSNumber*)videoWidth {
	[self willAccessValueForKey:@"videoWidth"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"videoWidth"];
	[self didAccessValueForKey:@"videoWidth"];
	return result;
}

- (void)setVideoWidth:(NSNumber*)value {
	[self willChangeValueForKey:@"videoWidth"];
	[self setPrimitiveValue:value forKey:@"videoWidth"];
	[self didChangeValueForKey:@"videoWidth"];
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