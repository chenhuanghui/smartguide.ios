// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Home.m instead.

#import "_Home.h"
#import "Home.h"

#import "DataManager.h"
#import "HomeImages.h"
#import "HomeShop.h"


@implementation _Home


@dynamic homeImage;



@dynamic homeShop;



+(Home*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Home" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Home*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Home" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Home alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryHome:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Home"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(Home*) queryHomeObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Home"];
    
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
    NSArray *array=[_Home queryHome:nil];
    
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



- (NSNumber*)type {
	[self willAccessValueForKey:@"type"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"type"];
	[self didAccessValueForKey:@"type"];
	return result;
}

- (void)setType:(NSNumber*)value {
	[self willChangeValueForKey:@"type"];
	[self setPrimitiveValue:value forKey:@"type"];
	[self didChangeValueForKey:@"type"];
}

#pragma mark Relationships
    
#pragma mark HomeImage
- (HomeImages*)homeImage {
	[self willAccessValueForKey:@"homeImage"];
	HomeImages *result = [self primitiveValueForKey:@"homeImage"];
	[self didAccessValueForKey:@"homeImage"];
	return result;
}

#pragma mark HomeShop
- (HomeShop*)homeShop {
	[self willAccessValueForKey:@"homeShop"];
	HomeShop *result = [self primitiveValueForKey:@"homeShop"];
	[self didAccessValueForKey:@"homeShop"];
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