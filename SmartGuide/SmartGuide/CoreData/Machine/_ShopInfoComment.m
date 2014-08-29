// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoComment.m instead.

#import "_ShopInfoComment.h"
#import "ShopInfoComment.h"

#import "DataManager.h"
#import "ShopInfo.h"


@implementation _ShopInfoComment


@dynamic shop;



+(ShopInfoComment*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopInfoComment" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopInfoComment*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopInfoComment" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopInfoComment alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopInfoComment:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfoComment"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopInfoComment*) queryShopInfoCommentObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfoComment"];
    
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
    NSArray *array=[_ShopInfoComment queryShopInfoComment:nil];
    
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