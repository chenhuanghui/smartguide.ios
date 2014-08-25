// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HomeShop.m instead.

#import "_HomeShop.h"
#import "HomeShop.h"

#import "DataManager.h"
#import "Home.h"
#import "ShopInfo.h"


@implementation _HomeShop


@dynamic home;



@dynamic shop;



+(HomeShop*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"HomeShop" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(HomeShop*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HomeShop" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[HomeShop alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryHomeShop:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HomeShop"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(HomeShop*) queryHomeShopObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HomeShop"];
    
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
    NSArray *array=[_HomeShop queryHomeShop:nil];
    
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

#pragma mark Relationships
    
#pragma mark Home
- (Home*)home {
	[self willAccessValueForKey:@"home"];
	Home *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
	return result;
}

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