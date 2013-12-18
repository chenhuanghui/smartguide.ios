// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopList.m instead.

#import "_ShopList.h"
#import "ShopList.h"

#import "DataManager.h"
#import "Placelist.h"


@implementation _ShopList


@dynamic placeList;



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



- (NSString*)address {
	[self willAccessValueForKey:@"address"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"address"];
	[self didAccessValueForKey:@"address"];
	return result;
}

- (void)setAddress:(NSString*)value {
	[self willChangeValueForKey:@"address"];
	[self setPrimitiveValue:value forKey:@"address"];
	[self didChangeValueForKey:@"address"];
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

- (NSString*)coverFullscreen {
	[self willAccessValueForKey:@"coverFullscreen"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"coverFullscreen"];
	[self didAccessValueForKey:@"coverFullscreen"];
	return result;
}

- (void)setCoverFullscreen:(NSString*)value {
	[self willChangeValueForKey:@"coverFullscreen"];
	[self setPrimitiveValue:value forKey:@"coverFullscreen"];
	[self didChangeValueForKey:@"coverFullscreen"];
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

- (NSString*)logo {
	[self willAccessValueForKey:@"logo"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"logo"];
	[self didAccessValueForKey:@"logo"];
	return result;
}

- (void)setLogo:(NSString*)value {
	[self willChangeValueForKey:@"logo"];
	[self setPrimitiveValue:value forKey:@"logo"];
	[self didChangeValueForKey:@"logo"];
}

- (NSNumber*)loveStatus {
	[self willAccessValueForKey:@"loveStatus"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"loveStatus"];
	[self didAccessValueForKey:@"loveStatus"];
	return result;
}

- (void)setLoveStatus:(NSNumber*)value {
	[self willChangeValueForKey:@"loveStatus"];
	[self setPrimitiveValue:value forKey:@"loveStatus"];
	[self didChangeValueForKey:@"loveStatus"];
}

- (NSString*)numOfComment {
	[self willAccessValueForKey:@"numOfComment"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numOfComment"];
	[self didAccessValueForKey:@"numOfComment"];
	return result;
}

- (void)setNumOfComment:(NSString*)value {
	[self willChangeValueForKey:@"numOfComment"];
	[self setPrimitiveValue:value forKey:@"numOfComment"];
	[self didChangeValueForKey:@"numOfComment"];
}

- (NSString*)numOfLove {
	[self willAccessValueForKey:@"numOfLove"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numOfLove"];
	[self didAccessValueForKey:@"numOfLove"];
	return result;
}

- (void)setNumOfLove:(NSString*)value {
	[self willChangeValueForKey:@"numOfLove"];
	[self setPrimitiveValue:value forKey:@"numOfLove"];
	[self didChangeValueForKey:@"numOfLove"];
}

- (NSString*)numOfView {
	[self willAccessValueForKey:@"numOfView"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numOfView"];
	[self didAccessValueForKey:@"numOfView"];
	return result;
}

- (void)setNumOfView:(NSString*)value {
	[self willChangeValueForKey:@"numOfView"];
	[self setPrimitiveValue:value forKey:@"numOfView"];
	[self didChangeValueForKey:@"numOfView"];
}

- (NSNumber*)promotionType {
	[self willAccessValueForKey:@"promotionType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"promotionType"];
	[self didAccessValueForKey:@"promotionType"];
	return result;
}

- (void)setPromotionType:(NSNumber*)value {
	[self willChangeValueForKey:@"promotionType"];
	[self setPrimitiveValue:value forKey:@"promotionType"];
	[self didChangeValueForKey:@"promotionType"];
}

- (NSNumber*)shopLat {
	[self willAccessValueForKey:@"shopLat"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shopLat"];
	[self didAccessValueForKey:@"shopLat"];
	return result;
}

- (void)setShopLat:(NSNumber*)value {
	[self willChangeValueForKey:@"shopLat"];
	[self setPrimitiveValue:value forKey:@"shopLat"];
	[self didChangeValueForKey:@"shopLat"];
}

- (NSNumber*)shopLng {
	[self willAccessValueForKey:@"shopLng"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shopLng"];
	[self didAccessValueForKey:@"shopLng"];
	return result;
}

- (void)setShopLng:(NSNumber*)value {
	[self willChangeValueForKey:@"shopLng"];
	[self setPrimitiveValue:value forKey:@"shopLng"];
	[self didChangeValueForKey:@"shopLng"];
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

- (NSNumber*)shopType {
	[self willAccessValueForKey:@"shopType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shopType"];
	[self didAccessValueForKey:@"shopType"];
	return result;
}

- (void)setShopType:(NSNumber*)value {
	[self willChangeValueForKey:@"shopType"];
	[self setPrimitiveValue:value forKey:@"shopType"];
	[self didChangeValueForKey:@"shopType"];
}

#pragma mark Relationships
    
#pragma mark PlaceList
- (Placelist*)placeList {
	[self willAccessValueForKey:@"placeList"];
	Placelist *result = [self primitiveValueForKey:@"placeList"];
	[self didAccessValueForKey:@"placeList"];
	return result;
}


@end