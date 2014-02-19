// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreShop.m instead.

#import "_StoreShop.h"
#import "StoreShop.h"

#import "DataManager.h"
#import "UserHome5.h"
#import "UserHome7.h"
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

- (NSNumber*)idStore {
	[self willAccessValueForKey:@"idStore"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idStore"];
	[self didAccessValueForKey:@"idStore"];
	return result;
}

- (void)setIdStore:(NSNumber*)value {
	[self willChangeValueForKey:@"idStore"];
	[self setPrimitiveValue:value forKey:@"idStore"];
	[self didChangeValueForKey:@"idStore"];
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

- (NSString*)storeName {
	[self willAccessValueForKey:@"storeName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"storeName"];
	[self didAccessValueForKey:@"storeName"];
	return result;
}

- (void)setStoreName:(NSString*)value {
	[self willChangeValueForKey:@"storeName"];
	[self setPrimitiveValue:value forKey:@"storeName"];
	[self didChangeValueForKey:@"storeName"];
}

- (NSString*)storeType {
	[self willAccessValueForKey:@"storeType"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"storeType"];
	[self didAccessValueForKey:@"storeType"];
	return result;
}

- (void)setStoreType:(NSString*)value {
	[self willChangeValueForKey:@"storeType"];
	[self setPrimitiveValue:value forKey:@"storeType"];
	[self didChangeValueForKey:@"storeType"];
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
    
#pragma mark Home5
- (NSSet*)home5 {
	[self willAccessValueForKey:@"home5"];
	NSSet *result = [self primitiveValueForKey:@"home5"];
	[self didAccessValueForKey:@"home5"];
	return result;
}

-(NSArray*) home5Objects
{
    NSSet *set=[self home5];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setHome5:(NSSet*)value {
	[self willChangeValueForKey:@"home5" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home5"] setSet:value];
	[self didChangeValueForKey:@"home5" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addHome5:(NSSet*)value {
	[self willChangeValueForKey:@"home5" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home5"] unionSet:value];
	[self didChangeValueForKey:@"home5" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeHome5:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"home5" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home5"] minusSet:value];
	[self didChangeValueForKey:@"home5" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addHome5Object:(UserHome5*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home5" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home5"] addObject:value];
	[self didChangeValueForKey:@"home5" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeHome5Object:(UserHome5*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home5" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home5"] removeObject:value];
	[self didChangeValueForKey:@"home5" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllHome5
{
    [self removeHome5:self.home5];
}

- (NSMutableSet*)home5Set {
	[self willAccessValueForKey:@"home5"];
	NSMutableSet *result = [self mutableSetValueForKey:@"home5"];
	[self didAccessValueForKey:@"home5"];
	return result;
}

#pragma mark Home7
- (NSSet*)home7 {
	[self willAccessValueForKey:@"home7"];
	NSSet *result = [self primitiveValueForKey:@"home7"];
	[self didAccessValueForKey:@"home7"];
	return result;
}

-(NSArray*) home7Objects
{
    NSSet *set=[self home7];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setHome7:(NSSet*)value {
	[self willChangeValueForKey:@"home7" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home7"] setSet:value];
	[self didChangeValueForKey:@"home7" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addHome7:(NSSet*)value {
	[self willChangeValueForKey:@"home7" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home7"] unionSet:value];
	[self didChangeValueForKey:@"home7" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeHome7:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"home7" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"home7"] minusSet:value];
	[self didChangeValueForKey:@"home7" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addHome7Object:(UserHome7*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home7" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home7"] addObject:value];
	[self didChangeValueForKey:@"home7" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeHome7Object:(UserHome7*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"home7" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"home7"] removeObject:value];
	[self didChangeValueForKey:@"home7" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllHome7
{
    [self removeHome7:self.home7];
}

- (NSMutableSet*)home7Set {
	[self willAccessValueForKey:@"home7"];
	NSMutableSet *result = [self mutableSetValueForKey:@"home7"];
	[self didAccessValueForKey:@"home7"];
	return result;
}

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


#pragma mark Utility

-(void) revert
{
    [[[DataManager shareInstance] managedObjectContext] refreshObject:self mergeChanges:false];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end