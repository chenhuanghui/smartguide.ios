// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopGallery.m instead.

#import "_ShopGallery.h"
#import "ShopGallery.h"

#import "DataManager.h"
#import "Shop.h"


@implementation _ShopGallery


@dynamic shop;



+(ShopGallery*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopGallery*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopGallery" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopGallery alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopGallery:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopGallery"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopGallery query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(ShopGallery*) queryShopGalleryObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopGallery"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopGallery query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_ShopGallery queryShopGallery:nil];
    
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

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"ShopGallery save error %@",error);
        
    return result;
}



- (NSNumber*)idShop {
	[self willAccessValueForKey:@"idShop"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idShop"];
	[self didAccessValueForKey:@"idShop"];
	return result;
}

- (void)setIdShop:(NSNumber*)value {
	[self willChangeValueForKey:@"idShop"];
	[self setPrimitiveValue:value forKey:@"idShop"];
	[self didChangeValueForKey:@"idShop"];
}

- (NSString*)image {
	[self willAccessValueForKey:@"image"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"image"];
	[self didAccessValueForKey:@"image"];
	return result;
}

- (void)setImage:(NSString*)value {
	[self willChangeValueForKey:@"image"];
	[self setPrimitiveValue:value forKey:@"image"];
	[self didChangeValueForKey:@"image"];
}

- (NSString*)thumbnail {
	[self willAccessValueForKey:@"thumbnail"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"thumbnail"];
	[self didAccessValueForKey:@"thumbnail"];
	return result;
}

- (void)setThumbnail:(NSString*)value {
	[self willChangeValueForKey:@"thumbnail"];
	[self setPrimitiveValue:value forKey:@"thumbnail"];
	[self didChangeValueForKey:@"thumbnail"];
}

#pragma mark Relationships
    
#pragma mark Shop
- (Shop*)shop {
	[self willAccessValueForKey:@"shop"];
	Shop *result = [self primitiveValueForKey:@"shop"];
	[self didAccessValueForKey:@"shop"];
	return result;
}


@end