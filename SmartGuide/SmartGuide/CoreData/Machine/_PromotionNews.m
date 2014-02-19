// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionNews.m instead.

#import "_PromotionNews.h"
#import "PromotionNews.h"

#import "DataManager.h"
#import "Shop.h"


@implementation _PromotionNews


@dynamic shop;



+(PromotionNews*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"PromotionNews" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(PromotionNews*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PromotionNews" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[PromotionNews alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryPromotionNews:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PromotionNews"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"PromotionNews query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(PromotionNews*) queryPromotionNewsObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PromotionNews"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"PromotionNews query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_PromotionNews queryPromotionNews:nil];
    
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
    
#pragma mark Shop
- (Shop*)shop {
	[self willAccessValueForKey:@"shop"];
	Shop *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
	return result;
}


#pragma mark Utility

-(void) revert
{
    [[[DataManager shareInstance] managedObjectContext] refreshObject:self mergeChanges:false];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end