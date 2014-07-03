// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopUserComment.m instead.

#import "_ShopUserComment.h"
#import "ShopUserComment.h"

#import "DataManager.h"
#import "Shop.h"
#import "Shop.h"


@implementation _ShopUserComment


@dynamic shopTime;



@dynamic shopTop;



+(ShopUserComment*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopUserComment" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopUserComment*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopUserComment" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopUserComment alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopUserComment:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopUserComment"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopUserComment*) queryShopUserCommentObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopUserComment"];
    
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
    NSArray *array=[_ShopUserComment queryShopUserComment:nil];
    
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



- (NSNumber*)agreeStatus {
	[self willAccessValueForKey:@"agreeStatus"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"agreeStatus"];
	[self didAccessValueForKey:@"agreeStatus"];
	return result;
}

- (void)setAgreeStatus:(NSNumber*)value {
	[self willChangeValueForKey:@"agreeStatus"];
	[self setPrimitiveValue:value forKey:@"agreeStatus"];
	[self didChangeValueForKey:@"agreeStatus"];
}

- (NSString*)avatar {
	[self willAccessValueForKey:@"avatar"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"avatar"];
	[self didAccessValueForKey:@"avatar"];
	return result;
}

- (void)setAvatar:(NSString*)value {
	[self willChangeValueForKey:@"avatar"];
	[self setPrimitiveValue:value forKey:@"avatar"];
	[self didChangeValueForKey:@"avatar"];
}

- (NSString*)comment {
	[self willAccessValueForKey:@"comment"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"comment"];
	[self didAccessValueForKey:@"comment"];
	return result;
}

- (void)setComment:(NSString*)value {
	[self willChangeValueForKey:@"comment"];
	[self setPrimitiveValue:value forKey:@"comment"];
	[self didChangeValueForKey:@"comment"];
}

- (NSNumber*)idComment {
	[self willAccessValueForKey:@"idComment"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idComment"];
	[self didAccessValueForKey:@"idComment"];
	return result;
}

- (void)setIdComment:(NSNumber*)value {
	[self willChangeValueForKey:@"idComment"];
	[self setPrimitiveValue:value forKey:@"idComment"];
	[self didChangeValueForKey:@"idComment"];
}

- (NSString*)numOfAgree {
	[self willAccessValueForKey:@"numOfAgree"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numOfAgree"];
	[self didAccessValueForKey:@"numOfAgree"];
	return result;
}

- (void)setNumOfAgree:(NSString*)value {
	[self willChangeValueForKey:@"numOfAgree"];
	[self setPrimitiveValue:value forKey:@"numOfAgree"];
	[self didChangeValueForKey:@"numOfAgree"];
}

- (NSString*)shopName {
	[self willAccessValueForKey:@"shopName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"shopName"];
	[self didAccessValueForKey:@"shopName"];
	return result;
}

- (void)setShopName:(NSString*)value {
	[self willChangeValueForKey:@"shopName"];
	[self setPrimitiveValue:value forKey:@"shopName"];
	[self didChangeValueForKey:@"shopName"];
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

- (NSNumber*)totalAgree {
	[self willAccessValueForKey:@"totalAgree"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"totalAgree"];
	[self didAccessValueForKey:@"totalAgree"];
	return result;
}

- (void)setTotalAgree:(NSNumber*)value {
	[self willChangeValueForKey:@"totalAgree"];
	[self setPrimitiveValue:value forKey:@"totalAgree"];
	[self didChangeValueForKey:@"totalAgree"];
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
    
#pragma mark ShopTime
- (Shop*)shopTime {
	[self willAccessValueForKey:@"shopTime"];
	Shop *result = [self primitiveValueForKey:@"shopTime"];
	[self didAccessValueForKey:@"shopTime"];
	return result;
}

#pragma mark ShopTop
- (Shop*)shopTop {
	[self willAccessValueForKey:@"shopTop"];
	Shop *result = [self primitiveValueForKey:@"shopTop"];
	[self didAccessValueForKey:@"shopTop"];
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