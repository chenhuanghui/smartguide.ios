// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Shop.m instead.

#import "_Shop.h"
#import "Shop.h"

#import "DataManager.h"
#import "UserHome4.h"
#import "UserHome6.h"
#import "UserHome8.h"
#import "ShopKM1.h"
#import "ShopGallery.h"
#import "ShopUserComment.h"
#import "ShopUserComment.h"
#import "ShopUserGallery.h"


@implementation _Shop


@dynamic home4;



@dynamic home6;



@dynamic home8;



@dynamic km1;















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
    
#pragma mark Home4
- (UserHome4*)home4 {
	[self willAccessValueForKey:@"home4"];
	UserHome4 *result = [self primitiveValueForKey:@"home4"];
	[self didAccessValueForKey:@"home4"];
	return result;
}

#pragma mark Home6
- (UserHome6*)home6 {
	[self willAccessValueForKey:@"home6"];
	UserHome6 *result = [self primitiveValueForKey:@"home6"];
	[self didAccessValueForKey:@"home6"];
	return result;
}

#pragma mark Home8
- (UserHome8*)home8 {
	[self willAccessValueForKey:@"home8"];
	UserHome8 *result = [self primitiveValueForKey:@"home8"];
	[self didAccessValueForKey:@"home8"];
	return result;
}

#pragma mark Km1
- (ShopKM1*)km1 {
	[self willAccessValueForKey:@"km1"];
	ShopKM1 *result = [self primitiveValueForKey:@"km1"];
	[self didAccessValueForKey:@"km1"];
	return result;
}

#pragma mark ShopGalleries
- (NSSet*)shopGalleries {
	[self willAccessValueForKey:@"shopGalleries"];
	NSSet *result = [self primitiveValueForKey:@"shopGalleries"];
	[self didAccessValueForKey:@"shopGalleries"];
	return result;
}

-(NSArray*) shopGalleriesObjects
{
    NSSet *set=[self shopGalleries];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setShopGalleries:(NSSet*)value {
	[self willChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGalleries"] setSet:value];
	[self didChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addShopGalleries:(NSSet*)value {
	[self willChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGalleries"] unionSet:value];
	[self didChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeShopGalleries:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGalleries"] minusSet:value];
	[self didChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addShopGalleriesObject:(ShopGallery*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopGalleries"] addObject:value];
	[self didChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeShopGalleriesObject:(ShopGallery*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopGalleries"] removeObject:value];
	[self didChangeValueForKey:@"shopGalleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllShopGalleries
{
    [self removeShopGalleries:self.shopGalleries];
}

- (NSMutableSet*)shopGalleriesSet {
	[self willAccessValueForKey:@"shopGalleries"];
	NSMutableSet *result = [self mutableSetValueForKey:@"shopGalleries"];
	[self didAccessValueForKey:@"shopGalleries"];
	return result;
}

#pragma mark TimeComments
- (NSSet*)timeComments {
	[self willAccessValueForKey:@"timeComments"];
	NSSet *result = [self primitiveValueForKey:@"timeComments"];
	[self didAccessValueForKey:@"timeComments"];
	return result;
}

-(NSArray*) timeCommentsObjects
{
    NSSet *set=[self timeComments];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setTimeComments:(NSSet*)value {
	[self willChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"timeComments"] setSet:value];
	[self didChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addTimeComments:(NSSet*)value {
	[self willChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"timeComments"] unionSet:value];
	[self didChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeTimeComments:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"timeComments"] minusSet:value];
	[self didChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addTimeCommentsObject:(ShopUserComment*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"timeComments"] addObject:value];
	[self didChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeTimeCommentsObject:(ShopUserComment*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"timeComments"] removeObject:value];
	[self didChangeValueForKey:@"timeComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllTimeComments
{
    [self removeTimeComments:self.timeComments];
}

- (NSMutableSet*)timeCommentsSet {
	[self willAccessValueForKey:@"timeComments"];
	NSMutableSet *result = [self mutableSetValueForKey:@"timeComments"];
	[self didAccessValueForKey:@"timeComments"];
	return result;
}

#pragma mark TopComments
- (NSSet*)topComments {
	[self willAccessValueForKey:@"topComments"];
	NSSet *result = [self primitiveValueForKey:@"topComments"];
	[self didAccessValueForKey:@"topComments"];
	return result;
}

-(NSArray*) topCommentsObjects
{
    NSSet *set=[self topComments];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setTopComments:(NSSet*)value {
	[self willChangeValueForKey:@"topComments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"topComments"] setSet:value];
	[self didChangeValueForKey:@"topComments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addTopComments:(NSSet*)value {
	[self willChangeValueForKey:@"topComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"topComments"] unionSet:value];
	[self didChangeValueForKey:@"topComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeTopComments:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"topComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"topComments"] minusSet:value];
	[self didChangeValueForKey:@"topComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addTopCommentsObject:(ShopUserComment*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"topComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"topComments"] addObject:value];
	[self didChangeValueForKey:@"topComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeTopCommentsObject:(ShopUserComment*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"topComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"topComments"] removeObject:value];
	[self didChangeValueForKey:@"topComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllTopComments
{
    [self removeTopComments:self.topComments];
}

- (NSMutableSet*)topCommentsSet {
	[self willAccessValueForKey:@"topComments"];
	NSMutableSet *result = [self mutableSetValueForKey:@"topComments"];
	[self didAccessValueForKey:@"topComments"];
	return result;
}

#pragma mark UserGalleries
- (NSSet*)userGalleries {
	[self willAccessValueForKey:@"userGalleries"];
	NSSet *result = [self primitiveValueForKey:@"userGalleries"];
	[self didAccessValueForKey:@"userGalleries"];
	return result;
}

-(NSArray*) userGalleriesObjects
{
    NSSet *set=[self userGalleries];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setUserGalleries:(NSSet*)value {
	[self willChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGalleries"] setSet:value];
	[self didChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addUserGalleries:(NSSet*)value {
	[self willChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGalleries"] unionSet:value];
	[self didChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeUserGalleries:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGalleries"] minusSet:value];
	[self didChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addUserGalleriesObject:(ShopUserGallery*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userGalleries"] addObject:value];
	[self didChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeUserGalleriesObject:(ShopUserGallery*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userGalleries"] removeObject:value];
	[self didChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllUserGalleries
{
    [self removeUserGalleries:self.userGalleries];
}

- (NSMutableSet*)userGalleriesSet {
	[self willAccessValueForKey:@"userGalleries"];
	NSMutableSet *result = [self mutableSetValueForKey:@"userGalleries"];
	[self didAccessValueForKey:@"userGalleries"];
	return result;
}


@end