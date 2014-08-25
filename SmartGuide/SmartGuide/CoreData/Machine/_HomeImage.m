// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HomeImage.m instead.

#import "_HomeImage.h"
#import "HomeImage.h"

#import "DataManager.h"
#import "HomeImages.h"


@implementation _HomeImage


@dynamic images;



+(HomeImage*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"HomeImage" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(HomeImage*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HomeImage" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[HomeImage alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryHomeImage:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HomeImage"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(HomeImage*) queryHomeImageObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HomeImage"];
    
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
    NSArray *array=[_HomeImage queryHomeImage:nil];
    
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
    
#pragma mark Images
- (HomeImages*)images {
	[self willAccessValueForKey:@"images"];
	HomeImages *result = [self primitiveValueForKey:@"images"];
	[self didAccessValueForKey:@"images"];
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