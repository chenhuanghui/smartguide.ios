// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopProduct.m instead.

#import "_ShopProduct.h"
#import "ShopProduct.h"

#import "DataManager.h"
#import "Shop.h"


@implementation _ShopProduct


@dynamic shop;



+(ShopProduct*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopProduct" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopProduct*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopProduct" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopProduct alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopProduct:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopProduct"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopProduct query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(ShopProduct*) queryShopProductObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopProduct"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ShopProduct query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_ShopProduct queryShopProduct:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"ShopProduct save error %@",error);
        
    return result;
}



- (NSString*)cat_name {
	[self willAccessValueForKey:@"cat_name"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"cat_name"];
	[self didAccessValueForKey:@"cat_name"];
	return result;
}

- (void)setCat_name:(NSString*)value {
	[self willChangeValueForKey:@"cat_name"];
	[self setPrimitiveValue:value forKey:@"cat_name"];
	[self didChangeValueForKey:@"cat_name"];
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

- (NSString*)images {
	[self willAccessValueForKey:@"images"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"images"];
	[self didAccessValueForKey:@"images"];
	return result;
}

- (void)setImages:(NSString*)value {
	[self willChangeValueForKey:@"images"];
	[self setPrimitiveValue:value forKey:@"images"];
	[self didChangeValueForKey:@"images"];
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

- (NSString*)price {
	[self willAccessValueForKey:@"price"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"price"];
	[self didAccessValueForKey:@"price"];
	return result;
}

- (void)setPrice:(NSString*)value {
	[self willChangeValueForKey:@"price"];
	[self setPrimitiveValue:value forKey:@"price"];
	[self didChangeValueForKey:@"price"];
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