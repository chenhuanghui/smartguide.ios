// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome2.m instead.

#import "_UserHome2.h"
#import "UserHome2.h"

#import "DataManager.h"
#import "UserHome.h"


@implementation _UserHome2


@dynamic home;



+(UserHome2*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserHome2" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserHome2*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserHome2" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserHome2 alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserHome2:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome2"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(UserHome2*) queryUserHome2Object:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome2"];
    
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
    NSArray *array=[_UserHome2 queryUserHome2:nil];
    
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
    
#pragma mark Home
- (UserHome*)home {
	[self willAccessValueForKey:@"home"];
	UserHome *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
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