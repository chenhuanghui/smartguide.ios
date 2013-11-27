// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Reward.m instead.

#import "_Reward.h"
#import "Reward.h"

#import "DataManager.h"


@implementation _Reward


+(Reward*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Reward" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Reward*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Reward" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Reward alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryReward:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reward"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Reward query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(Reward*) queryRewardObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reward"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Reward query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_Reward queryReward:nil];
    
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

- (NSNumber*)idReward {
	[self willAccessValueForKey:@"idReward"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idReward"];
	[self didAccessValueForKey:@"idReward"];
	return result;
}

- (void)setIdReward:(NSNumber*)value {
	[self willChangeValueForKey:@"idReward"];
	[self setPrimitiveValue:value forKey:@"idReward"];
	[self didChangeValueForKey:@"idReward"];
}

- (NSNumber*)score {
	[self willAccessValueForKey:@"score"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"score"];
	[self didAccessValueForKey:@"score"];
	return result;
}

- (void)setScore:(NSNumber*)value {
	[self willChangeValueForKey:@"score"];
	[self setPrimitiveValue:value forKey:@"score"];
	[self didChangeValueForKey:@"score"];
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

#pragma mark Relationships
    

@end