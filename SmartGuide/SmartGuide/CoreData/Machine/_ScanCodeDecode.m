// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeDecode.m instead.

#import "_ScanCodeDecode.h"
#import "ScanCodeDecode.h"

#import "DataManager.h"
#import "UserNotificationAction.h"
#import "ScanCodeResult.h"


@implementation _ScanCodeDecode





@dynamic result;



+(ScanCodeDecode*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ScanCodeDecode" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ScanCodeDecode*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ScanCodeDecode" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ScanCodeDecode alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryScanCodeDecode:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ScanCodeDecode"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ScanCodeDecode*) queryScanCodeDecodeObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ScanCodeDecode"];
    
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
    NSArray *array=[_ScanCodeDecode queryScanCodeDecode:nil];
    
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

- (NSString*)linkShare {
	[self willAccessValueForKey:@"linkShare"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"linkShare"];
	[self didAccessValueForKey:@"linkShare"];
	return result;
}

- (void)setLinkShare:(NSString*)value {
	[self willChangeValueForKey:@"linkShare"];
	[self setPrimitiveValue:value forKey:@"linkShare"];
	[self didChangeValueForKey:@"linkShare"];
}

- (NSNumber*)order {
	[self willAccessValueForKey:@"order"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"order"];
	[self didAccessValueForKey:@"order"];
	return result;
}

- (void)setOrder:(NSNumber*)value {
	[self willChangeValueForKey:@"order"];
	[self setPrimitiveValue:value forKey:@"order"];
	[self didChangeValueForKey:@"order"];
}

- (NSString*)text {
	[self willAccessValueForKey:@"text"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"text"];
	[self didAccessValueForKey:@"text"];
	return result;
}

- (void)setText:(NSString*)value {
	[self willChangeValueForKey:@"text"];
	[self setPrimitiveValue:value forKey:@"text"];
	[self didChangeValueForKey:@"text"];
}

- (NSNumber*)textHeight {
	[self willAccessValueForKey:@"textHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"textHeight"];
	[self didAccessValueForKey:@"textHeight"];
	return result;
}

- (void)setTextHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"textHeight"];
	[self setPrimitiveValue:value forKey:@"textHeight"];
	[self didChangeValueForKey:@"textHeight"];
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
    
#pragma mark Action
- (NSSet*)action {
	[self willAccessValueForKey:@"action"];
	NSSet *result = [self primitiveValueForKey:@"action"];
	[self didAccessValueForKey:@"action"];
	return result;
}

-(NSArray*) actionObjects
{
    NSSet *set=[self action];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setAction:(NSSet*)value {
	[self willChangeValueForKey:@"action" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"action"] setSet:value];
	[self didChangeValueForKey:@"action" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addAction:(NSSet*)value {
	[self willChangeValueForKey:@"action" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"action"] unionSet:value];
	[self didChangeValueForKey:@"action" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeAction:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"action" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"action"] minusSet:value];
	[self didChangeValueForKey:@"action" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addActionObject:(UserNotificationAction*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"action" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"action"] addObject:value];
	[self didChangeValueForKey:@"action" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeActionObject:(UserNotificationAction*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"action" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"action"] removeObject:value];
	[self didChangeValueForKey:@"action" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllAction
{
    [self removeAction:self.action];
}

- (NSMutableSet*)actionSet {
	[self willAccessValueForKey:@"action"];
	NSMutableSet *result = [self mutableSetValueForKey:@"action"];
	[self didAccessValueForKey:@"action"];
	return result;
}

#pragma mark Result
- (ScanCodeResult*)result {
	[self willAccessValueForKey:@"result"];
	ScanCodeResult *result = [self primitiveValueForKey:@"result"];
	[self didAccessValueForKey:@"result"];
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