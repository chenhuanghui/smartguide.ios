// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreShop.m instead.

#import "_StoreShop.h"
#import "StoreShop.h"

#import "DataManager.h"
#import "StoreShopItem.h"
#import "StoreShopItem.h"


@implementation _StoreShop








+(StoreShop*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"StoreShop" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(StoreShop*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoreShop" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[StoreShop alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryStoreShop:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"StoreShop"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"StoreShop query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(StoreShop*) queryStoreShopObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"StoreShop"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"StoreShop query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_StoreShop queryStoreShop:nil];
    
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



- (NSString*)condition {
	[self willAccessValueForKey:@"condition"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"condition"];
	[self didAccessValueForKey:@"condition"];
	return result;
}

- (void)setCondition:(NSString*)value {
	[self willChangeValueForKey:@"condition"];
	[self setPrimitiveValue:value forKey:@"condition"];
	[self didChangeValueForKey:@"condition"];
}

- (NSString*)conditionPair {
	[self willAccessValueForKey:@"conditionPair"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"conditionPair"];
	[self didAccessValueForKey:@"conditionPair"];
	return result;
}

- (void)setConditionPair:(NSString*)value {
	[self willChangeValueForKey:@"conditionPair"];
	[self setPrimitiveValue:value forKey:@"conditionPair"];
	[self didChangeValueForKey:@"conditionPair"];
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

- (NSString*)shopType {
	[self willAccessValueForKey:@"shopType"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"shopType"];
	[self didAccessValueForKey:@"shopType"];
	return result;
}

- (void)setShopType:(NSString*)value {
	[self willChangeValueForKey:@"shopType"];
	[self setPrimitiveValue:value forKey:@"shopType"];
	[self didChangeValueForKey:@"shopType"];
}

- (NSNumber*)sortOrder {
	[self willAccessValueForKey:@"sortOrder"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"sortOrder"];
	[self didAccessValueForKey:@"sortOrder"];
	return result;
}

- (void)setSortOrder:(NSNumber*)value {
	[self willChangeValueForKey:@"sortOrder"];
	[self setPrimitiveValue:value forKey:@"sortOrder"];
	[self didChangeValueForKey:@"sortOrder"];
}

- (NSString*)total {
	[self willAccessValueForKey:@"total"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"total"];
	[self didAccessValueForKey:@"total"];
	return result;
}

- (void)setTotal:(NSString*)value {
	[self willChangeValueForKey:@"total"];
	[self setPrimitiveValue:value forKey:@"total"];
	[self didChangeValueForKey:@"total"];
}

#pragma mark Relationships
    
#pragma mark LatestItems
- (NSSet*)latestItems {
	[self willAccessValueForKey:@"latestItems"];
	NSSet *result = [self primitiveValueForKey:@"latestItems"];
	[self didAccessValueForKey:@"latestItems"];
	return result;
}

-(NSArray*) latestItemsObjects
{
    NSSet *set=[self latestItems];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setLatestItems:(NSSet*)value {
	[self willChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"latestItems"] setSet:value];
	[self didChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addLatestItems:(NSSet*)value {
	[self willChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"latestItems"] unionSet:value];
	[self didChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeLatestItems:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"latestItems"] minusSet:value];
	[self didChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addLatestItemsObject:(StoreShopItem*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"latestItems"] addObject:value];
	[self didChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeLatestItemsObject:(StoreShopItem*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"latestItems"] removeObject:value];
	[self didChangeValueForKey:@"latestItems" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllLatestItems
{
    [self removeLatestItems:self.latestItems];
}

- (NSMutableSet*)latestItemsSet {
	[self willAccessValueForKey:@"latestItems"];
	NSMutableSet *result = [self mutableSetValueForKey:@"latestItems"];
	[self didAccessValueForKey:@"latestItems"];
	return result;
}

#pragma mark TopSellerItems
- (NSSet*)topSellerItems {
	[self willAccessValueForKey:@"topSellerItems"];
	NSSet *result = [self primitiveValueForKey:@"topSellerItems"];
	[self didAccessValueForKey:@"topSellerItems"];
	return result;
}

-(NSArray*) topSellerItemsObjects
{
    NSSet *set=[self topSellerItems];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setTopSellerItems:(NSSet*)value {
	[self willChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"topSellerItems"] setSet:value];
	[self didChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addTopSellerItems:(NSSet*)value {
	[self willChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"topSellerItems"] unionSet:value];
	[self didChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeTopSellerItems:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"topSellerItems"] minusSet:value];
	[self didChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addTopSellerItemsObject:(StoreShopItem*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"topSellerItems"] addObject:value];
	[self didChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeTopSellerItemsObject:(StoreShopItem*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"topSellerItems"] removeObject:value];
	[self didChangeValueForKey:@"topSellerItems" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllTopSellerItems
{
    [self removeTopSellerItems:self.topSellerItems];
}

- (NSMutableSet*)topSellerItemsSet {
	[self willAccessValueForKey:@"topSellerItems"];
	NSMutableSet *result = [self mutableSetValueForKey:@"topSellerItems"];
	[self didAccessValueForKey:@"topSellerItems"];
	return result;
}


@end