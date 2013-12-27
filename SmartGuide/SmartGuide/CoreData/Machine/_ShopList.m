// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopList.m instead.

#import "_ShopList.h"
#import "ShopList.h"

#import "DataManager.h"
#import "Placelist.h"
#import "Shop.h"


@implementation _ShopList


@dynamic placeList;



@dynamic shop;



+(ShopList*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopList" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopList*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopList" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopList alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopList:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopList"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopList query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(ShopList*) queryShopListObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopList"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopList query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_ShopList queryShopList:nil];
    
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



- (NSString*)desc {
	[self willAccessValueForKey:@"desc"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"desc"];
	[self didAccessValueForKey:@"desc"];
	return result;
}

- (void)setDesc:(NSString*)value {
	[self willChangeValueForKey:@"desc"];
	[self setPrimitiveValue:value forKey:@"desc"];
	[self didChangeValueForKey:@"desc"];
}

- (NSString*)distance {
	[self willAccessValueForKey:@"distance"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"distance"];
	[self didAccessValueForKey:@"distance"];
	return result;
}

- (void)setDistance:(NSString*)value {
	[self willChangeValueForKey:@"distance"];
	[self setPrimitiveValue:value forKey:@"distance"];
	[self didChangeValueForKey:@"distance"];
}

- (NSString*)shopName {
	[self willAccessValueForKey:@"shopName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"shopName"];
	[self didAccessValueForKey:@"shopName"];
	return result;
}

- (void)setShopName:(NSString*)value {
	[self willChangeValueForKey:@"shopName"];
	[self setPrimitiveValue:value forKey:@"shopName"];
	[self didChangeValueForKey:@"shopName"];
}

#pragma mark Relationships
    
#pragma mark PlaceList
- (Placelist*)placeList {
	[self willAccessValueForKey:@"placeList"];
	Placelist *result = [self primitiveValueForKey:@"placeList"];
	[self didAccessValueForKey:@"placeList"];
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