// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"
#import "User.h"

#import "DataManager.h"


@implementation _User


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

- (NSNumber*)gender {
	[self willAccessValueForKey:@"gender"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"gender"];
	[self didAccessValueForKey:@"gender"];
	return result;
}

- (void)setGender:(NSNumber*)value {
	[self willChangeValueForKey:@"gender"];
	[self setPrimitiveValue:value forKey:@"gender"];
	[self didChangeValueForKey:@"gender"];
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

- (NSString*)phone {
	[self willAccessValueForKey:@"phone"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"phone"];
	[self didAccessValueForKey:@"phone"];
	return result;
}

- (void)setPhone:(NSString*)value {
	[self willChangeValueForKey:@"phone"];
	[self setPrimitiveValue:value forKey:@"phone"];
	[self didChangeValueForKey:@"phone"];
}

- (NSNumber*)socialType {
	[self willAccessValueForKey:@"socialType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"socialType"];
	[self didAccessValueForKey:@"socialType"];
	return result;
}

- (void)setSocialType:(NSNumber*)value {
	[self willChangeValueForKey:@"socialType"];
	[self setPrimitiveValue:value forKey:@"socialType"];
	[self didChangeValueForKey:@"socialType"];
}

#pragma mark Relationships
    

@end