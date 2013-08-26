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

- (NSString*)created_at {
	[self willAccessValueForKey:@"created_at"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"created_at"];
	[self didAccessValueForKey:@"created_at"];
	return result;
}

- (void)setCreated_at:(NSString*)value {
	[self willChangeValueForKey:@"created_at"];
	[self setPrimitiveValue:value forKey:@"created_at"];
	[self didChangeValueForKey:@"created_at"];
}

- (NSNumber*)idFeedback {
	[self willAccessValueForKey:@"idFeedback"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idFeedback"];
	[self didAccessValueForKey:@"idFeedback"];
	return result;
}

- (void)setIdFeedback:(NSNumber*)value {
	[self willChangeValueForKey:@"idFeedback"];
	[self setPrimitiveValue:value forKey:@"idFeedback"];
	[self didChangeValueForKey:@"idFeedback"];
}

- (NSNumber*)idUser {
	[self willAccessValueForKey:@"idUser"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idUser"];
	[self didAccessValueForKey:@"idUser"];
	return result;
}

- (void)setIdUser:(NSNumber*)value {
	[self willChangeValueForKey:@"idUser"];
	[self setPrimitiveValue:value forKey:@"idUser"];
	[self didChangeValueForKey:@"idUser"];
}

#pragma mark Relationships
    

@end