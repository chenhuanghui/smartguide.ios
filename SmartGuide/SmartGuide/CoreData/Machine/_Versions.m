// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Versions.m instead.

#import "_Versions.h"
#import "Versions.h"

#import "DataManager.h"


@implementation _Versions


+(Versions*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Versions" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Versions*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Versions" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Versions alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryVersions:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Versions"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Versions query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(Versions*) queryVersionsObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Versions"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Versions query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_Versions queryVersions:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"Versions save error %@",error);
        
    return result;
}



- (NSString*)version {
	[self willAccessValueForKey:@"version"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"version"];
	[self didAccessValueForKey:@"version"];
	return result;
}

- (void)setVersion:(NSString*)value {
	[self willChangeValueForKey:@"version"];
	[self setPrimitiveValue:value forKey:@"version"];
	[self didChangeValueForKey:@"version"];
}

- (NSNumber*)versionType {
	[self willAccessValueForKey:@"versionType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"versionType"];
	[self didAccessValueForKey:@"versionType"];
	return result;
}

- (void)setVersionType:(NSNumber*)value {
	[self willChangeValueForKey:@"versionType"];
	[self setPrimitiveValue:value forKey:@"versionType"];
	[self didChangeValueForKey:@"versionType"];
}

#pragma mark Relationships
    

@end