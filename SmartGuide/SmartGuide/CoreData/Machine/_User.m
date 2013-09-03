// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"
#import "User.h"

#import "DataManager.h"
#import "Filter.h"


@implementation _User


@dynamic filter;



+(User*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(User*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[User alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUser:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"User query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(User*) queryUserObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"User query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_User queryUser:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"User save error %@",error);
        
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

- (NSNumber*)isConnectedFacebook {
	[self willAccessValueForKey:@"isConnectedFacebook"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"isConnectedFacebook"];
	[self didAccessValueForKey:@"isConnectedFacebook"];
	return result;
}

- (void)setIsConnectedFacebook:(NSNumber*)value {
	[self willChangeValueForKey:@"isConnectedFacebook"];
	[self setPrimitiveValue:value forKey:@"isConnectedFacebook"];
	[self didChangeValueForKey:@"isConnectedFacebook"];
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
    
#pragma mark Filter
- (Filter*)filter {
	[self willAccessValueForKey:@"filter"];
	Filter *result = [self primitiveValueForKey:@"filter"];
	[self didAccessValueForKey:@"filter"];
	return result;
}


@end