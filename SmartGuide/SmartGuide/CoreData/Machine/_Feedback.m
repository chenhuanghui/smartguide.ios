// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Feedback.m instead.

#import "_Feedback.h"
#import "Feedback.h"

#import "DataManager.h"


@implementation _Feedback


+(Feedback*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Feedback" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Feedback*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Feedback" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Feedback alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryFeedback:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Feedback"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Feedback query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(Feedback*) queryFeedbackObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Feedback"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Feedback query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_Feedback queryFeedback:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"Feedback save error %@",error);
        
    return result;
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

- (NSString*)user {
	[self willAccessValueForKey:@"user"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"user"];
	[self didAccessValueForKey:@"user"];
	return result;
}

- (void)setUser:(NSString*)value {
	[self willChangeValueForKey:@"user"];
	[self setPrimitiveValue:value forKey:@"user"];
	[self didChangeValueForKey:@"user"];
}

#pragma mark Relationships
    

@end