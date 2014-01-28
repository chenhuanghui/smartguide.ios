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



- (NSString*)activationCode {
	[self willAccessValueForKey:@"activationCode"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"activationCode"];
	[self didAccessValueForKey:@"activationCode"];
	return result;
}

- (void)setActivationCode:(NSString*)value {
	[self willChangeValueForKey:@"activationCode"];
	[self setPrimitiveValue:value forKey:@"activationCode"];
	[self didChangeValueForKey:@"activationCode"];
}

- (NSNumber*)allowShareCommentFB {
	[self willAccessValueForKey:@"allowShareCommentFB"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"allowShareCommentFB"];
	[self didAccessValueForKey:@"allowShareCommentFB"];
	return result;
}

- (void)setAllowShareCommentFB:(NSNumber*)value {
	[self willChangeValueForKey:@"allowShareCommentFB"];
	[self setPrimitiveValue:value forKey:@"allowShareCommentFB"];
	[self didChangeValueForKey:@"allowShareCommentFB"];
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

- (NSString*)birthday {
	[self willAccessValueForKey:@"birthday"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"birthday"];
	[self didAccessValueForKey:@"birthday"];
	return result;
}

- (void)setBirthday:(NSString*)value {
	[self willChangeValueForKey:@"birthday"];
	[self setPrimitiveValue:value forKey:@"birthday"];
	[self didChangeValueForKey:@"birthday"];
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

- (NSString*)facebookToken {
	[self willAccessValueForKey:@"facebookToken"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"facebookToken"];
	[self didAccessValueForKey:@"facebookToken"];
	return result;
}

- (void)setFacebookToken:(NSString*)value {
	[self willChangeValueForKey:@"facebookToken"];
	[self setPrimitiveValue:value forKey:@"facebookToken"];
	[self didChangeValueForKey:@"facebookToken"];
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

- (NSString*)googleplusToken {
	[self willAccessValueForKey:@"googleplusToken"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"googleplusToken"];
	[self didAccessValueForKey:@"googleplusToken"];
	return result;
}

- (void)setGoogleplusToken:(NSString*)value {
	[self willChangeValueForKey:@"googleplusToken"];
	[self setPrimitiveValue:value forKey:@"googleplusToken"];
	[self didChangeValueForKey:@"googleplusToken"];
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