// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome8.m instead.

#import "_UserHome8.h"
#import "UserHome8.h"

#import "DataManager.h"
#import "UserHome.h"
#import "Shop.h"


@implementation _UserHome8


@dynamic home;



@dynamic shop;



+(UserHome8*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserHome8" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(UserHome8*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserHome8" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[UserHome8 alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryUserHome8:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome8"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserHome8 query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(UserHome8*) queryUserHome8Object:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserHome8"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"UserHome8 query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_UserHome8 queryUserHome8:nil];
    
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

#pragma mark Relationships
    
#pragma mark Home
- (UserHome*)home {
	[self willAccessValueForKey:@"home"];
	UserHome *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
	return result;
}

#pragma mark Shop
- (Shop*)shop {
	[self willAccessValueForKey:@"shop"];
	Shop *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
	return result;
}


@end