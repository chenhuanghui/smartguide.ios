// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Ads.m instead.

#import "_Ads.h"
#import "Ads.h"

#import "DataManager.h"


@implementation _Ads


+(Ads*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Ads" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Ads*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ads" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Ads alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryAds:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Ads"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Ads query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(Ads*) queryAdsObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Ads"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Ads query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_Ads queryAds:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"Ads save error %@",error);
        
    return result;
}



- (NSString*)begin_date {
	[self willAccessValueForKey:@"begin_date"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"begin_date"];
	[self didAccessValueForKey:@"begin_date"];
	return result;
}

- (void)setBegin_date:(NSString*)value {
	[self willChangeValueForKey:@"begin_date"];
	[self setPrimitiveValue:value forKey:@"begin_date"];
	[self didChangeValueForKey:@"begin_date"];
}

- (NSString*)end_date {
	[self willAccessValueForKey:@"end_date"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"end_date"];
	[self didAccessValueForKey:@"end_date"];
	return result;
}

- (void)setEnd_date:(NSString*)value {
	[self willChangeValueForKey:@"end_date"];
	[self setPrimitiveValue:value forKey:@"end_date"];
	[self didChangeValueForKey:@"end_date"];
}

- (NSNumber*)idAds {
	[self willAccessValueForKey:@"idAds"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idAds"];
	[self didAccessValueForKey:@"idAds"];
	return result;
}

- (void)setIdAds:(NSNumber*)value {
	[self willChangeValueForKey:@"idAds"];
	[self setPrimitiveValue:value forKey:@"idAds"];
	[self didChangeValueForKey:@"idAds"];
}

- (NSData*)image {
	[self willAccessValueForKey:@"image"];
	NSData* result = (NSData*)[self primitiveValueForKey:@"image"];
	[self didAccessValueForKey:@"image"];
	return result;
}

- (void)setImage:(NSData*)value {
	[self willChangeValueForKey:@"image"];
	[self setPrimitiveValue:value forKey:@"image"];
	[self didChangeValueForKey:@"image"];
}

- (NSString*)image_url {
	[self willAccessValueForKey:@"image_url"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"image_url"];
	[self didAccessValueForKey:@"image_url"];
	return result;
}

- (void)setImage_url:(NSString*)value {
	[self willChangeValueForKey:@"image_url"];
	[self setPrimitiveValue:value forKey:@"image_url"];
	[self didChangeValueForKey:@"image_url"];
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