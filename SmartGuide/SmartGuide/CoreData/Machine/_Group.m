// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Group.m instead.

#import "_Group.h"
#import "Group.h"

#import "DataManager.h"


@implementation _Group


+(Group*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Group*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Group" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Group alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryGroup:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Group query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(Group*) queryGroupObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Group query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_Group queryGroup:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"Group save error %@",error);
        
    return result;
}



- (NSNumber*)count {
	[self willAccessValueForKey:@"count"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"count"];
	[self didAccessValueForKey:@"count"];
	return result;
}

- (void)setCount:(NSNumber*)value {
	[self willChangeValueForKey:@"count"];
	[self setPrimitiveValue:value forKey:@"count"];
	[self didChangeValueForKey:@"count"];
}

- (NSNumber*)idGroup {
	[self willAccessValueForKey:@"idGroup"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idGroup"];
	[self didAccessValueForKey:@"idGroup"];
	return result;
}

- (void)setIdGroup:(NSNumber*)value {
	[self willChangeValueForKey:@"idGroup"];
	[self setPrimitiveValue:value forKey:@"idGroup"];
	[self didChangeValueForKey:@"idGroup"];
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
    

@end