// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeRelated.m instead.

#import "_ScanCodeRelated.h"
#import "ScanCodeRelated.h"

#import "DataManager.h"
#import "ScanCodeRelatedContain.h"


@implementation _ScanCodeRelated


@dynamic relatedContain;



+(ScanCodeRelated*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ScanCodeRelated" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ScanCodeRelated*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ScanCodeRelated" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ScanCodeRelated alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryScanCodeRelated:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ScanCodeRelated"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ScanCodeRelated*) queryScanCodeRelatedObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ScanCodeRelated"];
    
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
    NSArray *array=[_ScanCodeRelated queryScanCodeRelated:nil];
    
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



- (NSString*)authorAvatar {
	[self willAccessValueForKey:@"authorAvatar"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"authorAvatar"];
	[self didAccessValueForKey:@"authorAvatar"];
	return result;
}

- (void)setAuthorAvatar:(NSString*)value {
	[self willChangeValueForKey:@"authorAvatar"];
	[self setPrimitiveValue:value forKey:@"authorAvatar"];
	[self didChangeValueForKey:@"authorAvatar"];
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

- (NSNumber*)descHeight {
	[self willAccessValueForKey:@"descHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"descHeight"];
	[self didAccessValueForKey:@"descHeight"];
	return result;
}

- (void)setDescHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"descHeight"];
	[self setPrimitiveValue:value forKey:@"descHeight"];
	[self didChangeValueForKey:@"descHeight"];
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

- (NSNumber*)idPlacelist {
	[self willAccessValueForKey:@"idPlacelist"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idPlacelist"];
	[self didAccessValueForKey:@"idPlacelist"];
	return result;
}

- (void)setIdPlacelist:(NSNumber*)value {
	[self willChangeValueForKey:@"idPlacelist"];
	[self setPrimitiveValue:value forKey:@"idPlacelist"];
	[self didChangeValueForKey:@"idPlacelist"];
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

- (NSString*)idShops {
	[self willAccessValueForKey:@"idShops"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"idShops"];
	[self didAccessValueForKey:@"idShops"];
	return result;
}

- (void)setIdShops:(NSString*)value {
	[self willChangeValueForKey:@"idShops"];
	[self setPrimitiveValue:value forKey:@"idShops"];
	[self didChangeValueForKey:@"idShops"];
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

- (NSNumber*)order {
	[self willAccessValueForKey:@"order"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"order"];
	[self didAccessValueForKey:@"order"];
	return result;
}

- (void)setOrder:(NSNumber*)value {
	[self willChangeValueForKey:@"order"];
	[self setPrimitiveValue:value forKey:@"order"];
	[self didChangeValueForKey:@"order"];
}

- (NSNumber*)page {
	[self willAccessValueForKey:@"page"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"page"];
	[self didAccessValueForKey:@"page"];
	return result;
}

- (void)setPage:(NSNumber*)value {
	[self willChangeValueForKey:@"page"];
	[self setPrimitiveValue:value forKey:@"page"];
	[self didChangeValueForKey:@"page"];
}

- (NSString*)placelistName {
	[self willAccessValueForKey:@"placelistName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"placelistName"];
	[self didAccessValueForKey:@"placelistName"];
	return result;
}

- (void)setPlacelistName:(NSString*)value {
	[self willChangeValueForKey:@"placelistName"];
	[self setPrimitiveValue:value forKey:@"placelistName"];
	[self didChangeValueForKey:@"placelistName"];
}

- (NSNumber*)placelistNameHeight {
	[self willAccessValueForKey:@"placelistNameHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"placelistNameHeight"];
	[self didAccessValueForKey:@"placelistNameHeight"];
	return result;
}

- (void)setPlacelistNameHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"placelistNameHeight"];
	[self setPrimitiveValue:value forKey:@"placelistNameHeight"];
	[self didChangeValueForKey:@"placelistNameHeight"];
}

- (NSNumber*)promotioNameHeight {
	[self willAccessValueForKey:@"promotioNameHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"promotioNameHeight"];
	[self didAccessValueForKey:@"promotioNameHeight"];
	return result;
}

- (void)setPromotioNameHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"promotioNameHeight"];
	[self setPrimitiveValue:value forKey:@"promotioNameHeight"];
	[self didChangeValueForKey:@"promotioNameHeight"];
}

- (NSString*)promotionName {
	[self willAccessValueForKey:@"promotionName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"promotionName"];
	[self didAccessValueForKey:@"promotionName"];
	return result;
}

- (void)setPromotionName:(NSString*)value {
	[self willChangeValueForKey:@"promotionName"];
	[self setPrimitiveValue:value forKey:@"promotionName"];
	[self didChangeValueForKey:@"promotionName"];
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

- (NSNumber*)shopNameHeight {
	[self willAccessValueForKey:@"shopNameHeight"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shopNameHeight"];
	[self didAccessValueForKey:@"shopNameHeight"];
	return result;
}

- (void)setShopNameHeight:(NSNumber*)value {
	[self willChangeValueForKey:@"shopNameHeight"];
	[self setPrimitiveValue:value forKey:@"shopNameHeight"];
	[self didChangeValueForKey:@"shopNameHeight"];
}

- (NSString*)time {
	[self willAccessValueForKey:@"time"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"time"];
	[self didAccessValueForKey:@"time"];
	return result;
}

- (void)setTime:(NSString*)value {
	[self willChangeValueForKey:@"time"];
	[self setPrimitiveValue:value forKey:@"time"];
	[self didChangeValueForKey:@"time"];
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
    
#pragma mark RelatedContain
- (ScanCodeRelatedContain*)relatedContain {
	[self willAccessValueForKey:@"relatedContain"];
	ScanCodeRelatedContain *result = [self primitiveValueForKey:@"relatedContain"];
	[self didAccessValueForKey:@"relatedContain"];
	return result;
}


#pragma mark Utility

-(void) revert
{
    [[[DataManager shareInstance] managedObjectContext] refreshObject:self mergeChanges:false];
}

-(void) save
{
    [[DataManager shareInstance] save];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end