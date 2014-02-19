// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.m instead.

#import "_City.h"
#import "City.h"

#import "DataManager.h"


@implementation _City


+(City*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(City*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"City" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[City alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryCity:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"City"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"City query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(City*) queryCityObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"City"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"City query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_City queryCity:nil];
    
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



- (NSNumber*)idCity {
	[self willAccessValueForKey:@"idCity"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idCity"];
	[self didAccessValueForKey:@"idCity"];
	return result;
}

- (void)setIdCity:(NSNumber*)value {
	[self willChangeValueForKey:@"idCity"];
	[self setPrimitiveValue:value forKey:@"idCity"];
	[self didChangeValueForKey:@"idCity"];
}

- (NSString*)name {
	[self willAccessValueForKey:@"name"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"name"];
	[self didAccessValueForKey:@"name"];
	return result;
}

- (void)setName:(NSString*)value {
	[self willChangeValueForKey:@"name"];
	[self setPrimitiveValue:value forKey:@"name"];
	[self didChangeValueForKey:@"name"];
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