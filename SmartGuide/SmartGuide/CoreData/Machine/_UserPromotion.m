// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserPromotion.m instead.

#import "_UserPromotion.h"
#import "UserPromotion.h"

#import "DataManager.h"


@implementation _UserPromotion


+(UserPromotion*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserPromotion" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserPromotion*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserPromotion" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserPromotion alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserPromotion:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserPromotion"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(UserPromotion*) queryUserPromotionObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserPromotion"];
    
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
    NSArray *array=[_UserPromotion queryUserPromotion:nil];
    
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



- (NSString*)brandName {
	[self willAccessValueForKey:@"brandName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"brandName"];
	[self didAccessValueForKey:@"brandName"];
	return result;
}

- (void)setBrandName:(NSString*)value {
	[self willChangeValueForKey:@"brandName"];
	[self setPrimitiveValue:value forKey:@"brandName"];
	[self didChangeValueForKey:@"brandName"];
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

- (NSString*)date {
	[self willAccessValueForKey:@"date"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"date"];
	[self didAccessValueForKey:@"date"];
	return result;
}

- (void)setDate:(NSString*)value {
	[self willChangeValueForKey:@"date"];
	[self setPrimitiveValue:value forKey:@"date"];
	[self didChangeValueForKey:@"date"];
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

- (NSString*)goTo {
	[self willAccessValueForKey:@"goTo"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"goTo"];
	[self didAccessValueForKey:@"goTo"];
	return result;
}

- (void)setGoTo:(NSString*)value {
	[self willChangeValueForKey:@"goTo"];
	[self setPrimitiveValue:value forKey:@"goTo"];
	[self didChangeValueForKey:@"goTo"];
}

- (NSNumber*)idItem {
	[self willAccessValueForKey:@"idItem"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idItem"];
	[self didAccessValueForKey:@"idItem"];
	return result;
}

- (void)setIdItem:(NSNumber*)value {
	[self willChangeValueForKey:@"idItem"];
	[self setPrimitiveValue:value forKey:@"idItem"];
	[self didChangeValueForKey:@"idItem"];
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

- (NSNumber*)idStore {
	[self willAccessValueForKey:@"idStore"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idStore"];
	[self didAccessValueForKey:@"idStore"];
	return result;
}

- (void)setIdStore:(NSNumber*)value {
	[self willChangeValueForKey:@"idStore"];
	[self setPrimitiveValue:value forKey:@"idStore"];
	[self didChangeValueForKey:@"idStore"];
}

- (NSString*)logo {
	[self willAccessValueForKey:@"logo"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"logo"];
	[self didAccessValueForKey:@"logo"];
	return result;
}

- (void)setLogo:(NSString*)value {
	[self willChangeValueForKey:@"logo"];
	[self setPrimitiveValue:value forKey:@"logo"];
	[self didChangeValueForKey:@"logo"];
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