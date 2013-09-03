// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Shop.m instead.

#import "_Shop.h"
#import "Shop.h"

#import "DataManager.h"
#import "ShopProduct.h"
#import "PromotionDetail.h"
#import "ShopGallery.h"
#import "ShopUserComment.h"
#import "ShopUserGallery.h"


@implementation _Shop





@dynamic promotionDetail;












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

-(bool) save
{
    NSError *error=nil;
    bool result = [self.managedObjectContext save:&error];
    
    if(error)
        NSLog(@"Shop save error %@",error);
        
    return result;
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

- (NSString*)contact {
	[self willAccessValueForKey:@"contact"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"contact"];
	[self didAccessValueForKey:@"contact"];
	return result;
}

- (void)setContact:(NSString*)value {
	[self willChangeValueForKey:@"contact"];
	[self setPrimitiveValue:value forKey:@"contact"];
	[self didChangeValueForKey:@"contact"];
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

- (NSNumber*)dislike {
	[self willAccessValueForKey:@"dislike"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"dislike"];
	[self didAccessValueForKey:@"dislike"];
	return result;
}

- (void)setDislike:(NSNumber*)value {
	[self willChangeValueForKey:@"dislike"];
	[self setPrimitiveValue:value forKey:@"dislike"];
	[self didChangeValueForKey:@"dislike"];
}

- (NSNumber*)distance {
	[self willAccessValueForKey:@"distance"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"distance"];
	[self didAccessValueForKey:@"distance"];
	return result;
}

- (void)setDistance:(NSNumber*)value {
	[self willChangeValueForKey:@"distance"];
	[self setPrimitiveValue:value forKey:@"distance"];
	[self didChangeValueForKey:@"distance"];
}

- (NSString*)gallery {
	[self willAccessValueForKey:@"gallery"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"gallery"];
	[self didAccessValueForKey:@"gallery"];
	return result;
}

- (void)setGallery:(NSString*)value {
	[self willChangeValueForKey:@"gallery"];
	[self setPrimitiveValue:value forKey:@"gallery"];
	[self didChangeValueForKey:@"gallery"];
}

- (NSNumber*)idGroup {
	[self willAccessValueForKey:@"idGroup"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idGroup"];
	[self didAccessValueForKey:@"idGroup"];
	return result;
}

- (void)setIdGroup:(NSNumber*)value {
	[self willChangeValueForKey:@"idGroup"];
	[self setPrimitiveValue:value forKey:@"idGroup"];
	[self didChangeValueForKey:@"idGroup"];
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

- (NSNumber*)isNeedReloadData {
	[self willAccessValueForKey:@"isNeedReloadData"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"isNeedReloadData"];
	[self didAccessValueForKey:@"isNeedReloadData"];
	return result;
}

- (void)setIsNeedReloadData:(NSNumber*)value {
	[self willChangeValueForKey:@"isNeedReloadData"];
	[self setPrimitiveValue:value forKey:@"isNeedReloadData"];
	[self didChangeValueForKey:@"isNeedReloadData"];
}

- (NSNumber*)isShopDetail {
	[self willAccessValueForKey:@"isShopDetail"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"isShopDetail"];
	[self didAccessValueForKey:@"isShopDetail"];
	return result;
}

- (void)setIsShopDetail:(NSNumber*)value {
	[self willChangeValueForKey:@"isShopDetail"];
	[self setPrimitiveValue:value forKey:@"isShopDetail"];
	[self didChangeValueForKey:@"isShopDetail"];
}

- (NSNumber*)like {
	[self willAccessValueForKey:@"like"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"like"];
	[self didAccessValueForKey:@"like"];
	return result;
}

- (void)setLike:(NSNumber*)value {
	[self willChangeValueForKey:@"like"];
	[self setPrimitiveValue:value forKey:@"like"];
	[self didChangeValueForKey:@"like"];
}

- (NSNumber*)like_status {
	[self willAccessValueForKey:@"like_status"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"like_status"];
	[self didAccessValueForKey:@"like_status"];
	return result;
}

- (void)setLike_status:(NSNumber*)value {
	[self willChangeValueForKey:@"like_status"];
	[self setPrimitiveValue:value forKey:@"like_status"];
	[self didChangeValueForKey:@"like_status"];
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

- (NSNumber*)love {
	[self willAccessValueForKey:@"love"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"love"];
	[self didAccessValueForKey:@"love"];
	return result;
}

- (void)setLove:(NSNumber*)value {
	[self willChangeValueForKey:@"love"];
	[self setPrimitiveValue:value forKey:@"love"];
	[self didChangeValueForKey:@"love"];
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

- (NSNumber*)numGetPromotion {
	[self willAccessValueForKey:@"numGetPromotion"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"numGetPromotion"];
	[self didAccessValueForKey:@"numGetPromotion"];
	return result;
}

- (void)setNumGetPromotion:(NSNumber*)value {
	[self willChangeValueForKey:@"numGetPromotion"];
	[self setPrimitiveValue:value forKey:@"numGetPromotion"];
	[self didChangeValueForKey:@"numGetPromotion"];
}

- (NSNumber*)numGetReward {
	[self willAccessValueForKey:@"numGetReward"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"numGetReward"];
	[self didAccessValueForKey:@"numGetReward"];
	return result;
}

- (void)setNumGetReward:(NSNumber*)value {
	[self willChangeValueForKey:@"numGetReward"];
	[self setPrimitiveValue:value forKey:@"numGetReward"];
	[self didChangeValueForKey:@"numGetReward"];
}

- (NSNumber*)numOfDislike {
	[self willAccessValueForKey:@"numOfDislike"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"numOfDislike"];
	[self didAccessValueForKey:@"numOfDislike"];
	return result;
}

- (void)setNumOfDislike:(NSNumber*)value {
	[self willChangeValueForKey:@"numOfDislike"];
	[self setPrimitiveValue:value forKey:@"numOfDislike"];
	[self didChangeValueForKey:@"numOfDislike"];
}

- (NSNumber*)numOfLike {
	[self willAccessValueForKey:@"numOfLike"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"numOfLike"];
	[self didAccessValueForKey:@"numOfLike"];
	return result;
}

- (void)setNumOfLike:(NSNumber*)value {
	[self willChangeValueForKey:@"numOfLike"];
	[self setPrimitiveValue:value forKey:@"numOfLike"];
	[self didChangeValueForKey:@"numOfLike"];
}

- (NSNumber*)numOfVisit {
	[self willAccessValueForKey:@"numOfVisit"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"numOfVisit"];
	[self didAccessValueForKey:@"numOfVisit"];
	return result;
}

- (void)setNumOfVisit:(NSNumber*)value {
	[self willChangeValueForKey:@"numOfVisit"];
	[self setPrimitiveValue:value forKey:@"numOfVisit"];
	[self didChangeValueForKey:@"numOfVisit"];
}

- (NSNumber*)promotionStatus {
	[self willAccessValueForKey:@"promotionStatus"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"promotionStatus"];
	[self didAccessValueForKey:@"promotionStatus"];
	return result;
}

- (void)setPromotionStatus:(NSNumber*)value {
	[self willChangeValueForKey:@"promotionStatus"];
	[self setPrimitiveValue:value forKey:@"promotionStatus"];
	[self didChangeValueForKey:@"promotionStatus"];
}

- (NSNumber*)shop_lat {
	[self willAccessValueForKey:@"shop_lat"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shop_lat"];
	[self didAccessValueForKey:@"shop_lat"];
	return result;
}

- (void)setShop_lat:(NSNumber*)value {
	[self willChangeValueForKey:@"shop_lat"];
	[self setPrimitiveValue:value forKey:@"shop_lat"];
	[self didChangeValueForKey:@"shop_lat"];
}

- (NSNumber*)shop_lng {
	[self willAccessValueForKey:@"shop_lng"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"shop_lng"];
	[self didAccessValueForKey:@"shop_lng"];
	return result;
}

- (void)setShop_lng:(NSNumber*)value {
	[self willChangeValueForKey:@"shop_lng"];
	[self setPrimitiveValue:value forKey:@"shop_lng"];
	[self didChangeValueForKey:@"shop_lng"];
}

- (NSString*)updated_at {
	[self willAccessValueForKey:@"updated_at"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"updated_at"];
	[self didAccessValueForKey:@"updated_at"];
	return result;
}

- (void)setUpdated_at:(NSString*)value {
	[self willChangeValueForKey:@"updated_at"];
	[self setPrimitiveValue:value forKey:@"updated_at"];
	[self didChangeValueForKey:@"updated_at"];
}

- (NSString*)website {
	[self willAccessValueForKey:@"website"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"website"];
	[self didAccessValueForKey:@"website"];
	return result;
}

- (void)setWebsite:(NSString*)value {
	[self willChangeValueForKey:@"website"];
	[self setPrimitiveValue:value forKey:@"website"];
	[self didChangeValueForKey:@"website"];
}

#pragma mark Relationships
    
#pragma mark Products
- (NSSet*)products {
	[self willAccessValueForKey:@"products"];
	NSSet *result = [self primitiveValueForKey:@"products"];
	[self didAccessValueForKey:@"products"];
	return result;
}

-(NSArray*) productsObjects
{
    NSSet *set=[self products];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setProducts:(NSSet*)value {
	[self willChangeValueForKey:@"products" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"products"] setSet:value];
	[self didChangeValueForKey:@"products" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addProducts:(NSSet*)value {
	[self willChangeValueForKey:@"products" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"products"] unionSet:value];
	[self didChangeValueForKey:@"products" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeProducts:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"products" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"products"] minusSet:value];
	[self didChangeValueForKey:@"products" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addProductsObject:(ShopProduct*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"products" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"products"] addObject:value];
	[self didChangeValueForKey:@"products" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeProductsObject:(ShopProduct*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"products" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"products"] removeObject:value];
	[self didChangeValueForKey:@"products" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];
	NSMutableSet *result = [self mutableSetValueForKey:@"products"];
	[self didAccessValueForKey:@"products"];
	return result;
}

#pragma mark PromotionDetail
- (PromotionDetail*)promotionDetail {
	[self willAccessValueForKey:@"promotionDetail"];
	PromotionDetail *result = [self primitiveValueForKey:@"promotionDetail"];
	[self didAccessValueForKey:@"promotionDetail"];
	return result;
}

#pragma mark ShopGallery
- (NSSet*)shopGallery {
	[self willAccessValueForKey:@"shopGallery"];
	NSSet *result = [self primitiveValueForKey:@"shopGallery"];
	[self didAccessValueForKey:@"shopGallery"];
	return result;
}

-(NSArray*) shopGalleryObjects
{
    NSSet *set=[self shopGallery];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setShopGallery:(NSSet*)value {
	[self willChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGallery"] setSet:value];
	[self didChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addShopGallery:(NSSet*)value {
	[self willChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGallery"] unionSet:value];
	[self didChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeShopGallery:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopGallery"] minusSet:value];
	[self didChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addShopGalleryObject:(ShopGallery*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopGallery"] addObject:value];
	[self didChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeShopGalleryObject:(ShopGallery*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopGallery"] removeObject:value];
	[self didChangeValueForKey:@"shopGallery" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)shopGallerySet {
	[self willAccessValueForKey:@"shopGallery"];
	NSMutableSet *result = [self mutableSetValueForKey:@"shopGallery"];
	[self didAccessValueForKey:@"shopGallery"];
	return result;
}

#pragma mark ShopUserComments
- (NSSet*)shopUserComments {
	[self willAccessValueForKey:@"shopUserComments"];
	NSSet *result = [self primitiveValueForKey:@"shopUserComments"];
	[self didAccessValueForKey:@"shopUserComments"];
	return result;
}

-(NSArray*) shopUserCommentsObjects
{
    NSSet *set=[self shopUserComments];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setShopUserComments:(NSSet*)value {
	[self willChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopUserComments"] setSet:value];
	[self didChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addShopUserComments:(NSSet*)value {
	[self willChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopUserComments"] unionSet:value];
	[self didChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeShopUserComments:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"shopUserComments"] minusSet:value];
	[self didChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addShopUserCommentsObject:(ShopUserComment*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopUserComments"] addObject:value];
	[self didChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeShopUserCommentsObject:(ShopUserComment*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"shopUserComments"] removeObject:value];
	[self didChangeValueForKey:@"shopUserComments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)shopUserCommentsSet {
	[self willAccessValueForKey:@"shopUserComments"];
	NSMutableSet *result = [self mutableSetValueForKey:@"shopUserComments"];
	[self didAccessValueForKey:@"shopUserComments"];
	return result;
}

#pragma mark UserGallery
- (NSSet*)userGallery {
	[self willAccessValueForKey:@"userGallery"];
	NSSet *result = [self primitiveValueForKey:@"userGallery"];
	[self didAccessValueForKey:@"userGallery"];
	return result;
}

-(NSArray*) userGalleryObjects
{
    NSSet *set=[self userGallery];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setUserGallery:(NSSet*)value {
	[self willChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGallery"] setSet:value];
	[self didChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addUserGallery:(NSSet*)value {
	[self willChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGallery"] unionSet:value];
	[self didChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeUserGallery:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"userGallery"] minusSet:value];
	[self didChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addUserGalleryObject:(ShopUserGallery*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userGallery"] addObject:value];
	[self didChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeUserGalleryObject:(ShopUserGallery*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userGallery"] removeObject:value];
	[self didChangeValueForKey:@"userGallery" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (NSMutableSet*)userGallerySet {
	[self willAccessValueForKey:@"userGallery"];
	NSMutableSet *result = [self mutableSetValueForKey:@"userGallery"];
	[self didAccessValueForKey:@"userGallery"];
	return result;
}


@end