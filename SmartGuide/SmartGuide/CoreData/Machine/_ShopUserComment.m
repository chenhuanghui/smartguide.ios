// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopUserComment.m instead.

#import "_ShopUserComment.h"
#import "ShopUserComment.h"

#import "DataManager.h"
#import "Shop.h"


@implementation _ShopUserComment


@dynamic shop;



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
    
    if(error)
        NSLog(@"ShopUserComment query error %@ predicate %@",error,predicate);
    
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
    
    if(error)
        NSLog(@"ShopUserComment query error %@ predicate %@",error,predicate);
    
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

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"ShopUserComment save error %@",error);
        
    return result;
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

- (NSString*)fulltime {
	[self willAccessValueForKey:@"fulltime"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"fulltime"];
	[self didAccessValueForKey:@"fulltime"];
	return result;
}

- (void)setFulltime:(NSString*)value {
	[self willChangeValueForKey:@"fulltime"];
	[self setPrimitiveValue:value forKey:@"fulltime"];
	[self didChangeValueForKey:@"fulltime"];
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

- (NSString*)user {
	[self willAccessValueForKey:@"user"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"user"];
	[self didAccessValueForKey:@"user"];
	return result;
}

- (void)setUser:(NSString*)value {
	[self willChangeValueForKey:@"user"];
	[self setPrimitiveValue:value forKey:@"user"];
	[self didChangeValueForKey:@"user"];
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