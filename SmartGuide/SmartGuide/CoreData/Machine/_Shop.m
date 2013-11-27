// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Shop.m instead.

#import "_Shop.h"
#import "Shop.h"

#import "DataManager.h"
#import "ShopCatalog.h"
#import "ShopKM1.h"
#import "ShopGallery.h"
#import "ShopUserComment.h"
#import "ShopUserGallery.h"


@implementation _Shop


@dynamic catalog;



@dynamic km1s;












+(Shop*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(Shop*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[Shop alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShop:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Shop"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Shop query error %@ predicate %@",error,predicate);
    
    return result?result:[NSArray array];
}

+(Shop*) queryShopObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Shop"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"Shop query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_Shop queryShop:nil];
    
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

- (NSString*)city {
	[self willAccessValueForKey:@"city"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"city"];
	[self didAccessValueForKey:@"city"];
	return result;
}

- (void)setCity:(NSString*)value {
	[self willChangeValueForKey:@"city"];
	[self setPrimitiveValue:value forKey:@"city"];
	[self didChangeValueForKey:@"city"];
}

- (NSString*)displayTel {
	[self willAccessValueForKey:@"displayTel"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"displayTel"];
	[self didAccessValueForKey:@"displayTel"];
	return result;
}

- (void)setDisplayTel:(NSString*)value {
	[self willChangeValueForKey:@"displayTel"];
	[self setPrimitiveValue:value forKey:@"displayTel"];
	[self didChangeValueForKey:@"displayTel"];
}

- (NSString*)groupName {
	[self willAccessValueForKey:@"groupName"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"groupName"];
	[self didAccessValueForKey:@"groupName"];
	return result;
}

- (void)setGroupName:(NSString*)value {
	[self willChangeValueForKey:@"groupName"];
	[self setPrimitiveValue:value forKey:@"groupName"];
	[self didChangeValueForKey:@"groupName"];
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

- (NSString*)tel {
	[self willAccessValueForKey:@"tel"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"tel"];
	[self didAccessValueForKey:@"tel"];
	return result;
}

- (void)setTel:(NSString*)value {
	[self willChangeValueForKey:@"tel"];
	[self setPrimitiveValue:value forKey:@"tel"];
	[self didChangeValueForKey:@"tel"];
}

#pragma mark Relationships
    
#pragma mark Catalog
- (ShopCatalog*)catalog {
	[self willAccessValueForKey:@"catalog"];
	ShopCatalog *result = [self primitiveValueForKey:@"catalog"];
	[self didAccessValueForKey:@"catalog"];
	return result;
}

#pragma mark Km1s
- (ShopKM1*)km1s {
	[self willAccessValueForKey:@"km1s"];
	ShopKM1 *result = [self primitiveValueForKey:@"km1s"];
	[self didAccessValueForKey:@"km1s"];
	return result;
}

#pragma mark ShopGallerys
- (NSSet*)shopGallerys {
	[self willAccessValueForKey:@"shopGallerys"];
	NSSet *result = [self primitiveValueForKey:@"shopGallerys"];
	[self didAccessValueForKey:@"shopGallerys"];
	return result;
}

-(NSArray*) shopGallerysObjects
{
    NSSet *set=[self shopGallerys];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setShopGallerys:(NSSet*)value {
	[self willChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGallerys"] setSet:value];
	[self didChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addShopGallerys:(NSSet*)value {
	[self willChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGallerys"] unionSet:value];
	[self didChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeShopGallerys:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGallerys"] minusSet:value];
	[self didChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addShopGallerysObject:(ShopGallery*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopGallerys"] addObject:value];
	[self didChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeShopGallerysObject:(ShopGallery*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopGallerys"] removeObject:value];
	[self didChangeValueForKey:@"shopGallerys" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)shopGallerysSet {
	[self willAccessValueForKey:@"shopGallerys"];
	NSMutableSet *result = [self mutableSetValueForKey:@"shopGallerys"];
	[self didAccessValueForKey:@"shopGallerys"];
	return result;
}

#pragma mark UserComments
- (NSSet*)userComments {
	[self willAccessValueForKey:@"userComments"];
	NSSet *result = [self primitiveValueForKey:@"userComments"];
	[self didAccessValueForKey:@"userComments"];
	return result;
}

-(NSArray*) userCommentsObjects
{
    NSSet *set=[self userComments];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setUserComments:(NSSet*)value {
	[self willChangeValueForKey:@"userComments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userComments"] setSet:value];
	[self didChangeValueForKey:@"userComments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addUserComments:(NSSet*)value {
	[self willChangeValueForKey:@"userComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userComments"] unionSet:value];
	[self didChangeValueForKey:@"userComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeUserComments:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"userComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userComments"] minusSet:value];
	[self didChangeValueForKey:@"userComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addUserCommentsObject:(ShopUserComment*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userComments"] addObject:value];
	[self didChangeValueForKey:@"userComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeUserCommentsObject:(ShopUserComment*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userComments"] removeObject:value];
	[self didChangeValueForKey:@"userComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)userCommentsSet {
	[self willAccessValueForKey:@"userComments"];
	NSMutableSet *result = [self mutableSetValueForKey:@"userComments"];
	[self didAccessValueForKey:@"userComments"];
	return result;
}

#pragma mark UserGallerys
- (NSSet*)userGallerys {
	[self willAccessValueForKey:@"userGallerys"];
	NSSet *result = [self primitiveValueForKey:@"userGallerys"];
	[self didAccessValueForKey:@"userGallerys"];
	return result;
}

-(NSArray*) userGallerysObjects
{
    NSSet *set=[self userGallerys];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setUserGallerys:(NSSet*)value {
	[self willChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGallerys"] setSet:value];
	[self didChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addUserGallerys:(NSSet*)value {
	[self willChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGallerys"] unionSet:value];
	[self didChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeUserGallerys:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGallerys"] minusSet:value];
	[self didChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addUserGallerysObject:(ShopUserGallery*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userGallerys"] addObject:value];
	[self didChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeUserGallerysObject:(ShopUserGallery*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userGallerys"] removeObject:value];
	[self didChangeValueForKey:@"userGallerys" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)userGallerysSet {
	[self willAccessValueForKey:@"userGallerys"];
	NSMutableSet *result = [self mutableSetValueForKey:@"userGallerys"];
	[self didAccessValueForKey:@"userGallerys"];
	return result;
}


@end