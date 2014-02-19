// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tutorial.m instead.

#import "_Tutorial.h"
#import "Tutorial.h"

#import "DataManager.h"


@implementation _Tutorial


+(Tutorial*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Tutorial" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Tutorial*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tutorial" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Tutorial alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryTutorial:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tutorial"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Tutorial query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(Tutorial*) queryTutorialObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tutorial"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Tutorial query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_Tutorial queryTutorial:nil];
    
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



- (NSNumber*)idTutorial {
	[self willAccessValueForKey:@"idTutorial"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idTutorial"];
	[self didAccessValueForKey:@"idTutorial"];
	return result;
}

- (void)setIdTutorial:(NSNumber*)value {
	[self willChangeValueForKey:@"idTutorial"];
	[self setPrimitiveValue:value forKey:@"idTutorial"];
	[self didChangeValueForKey:@"idTutorial"];
}

- (NSNumber*)image {
	[self willAccessValueForKey:@"image"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"image"];
	[self didAccessValueForKey:@"image"];
	return result;
}

- (void)setImage:(NSNumber*)value {
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

#pragma mark Relationships
    

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