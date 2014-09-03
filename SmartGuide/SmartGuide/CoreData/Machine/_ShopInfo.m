// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfo.m instead.

#import "_ShopInfo.h"
#import "ShopInfo.h"

#import "DataManager.h"
#import "ShopInfoComment.h"
#import "ShopInfoEvent.h"
#import "ShopInfoGallery.h"
#import "HomeShop.h"
#import "ShopInfoList.h"
#import "ShopInfoUserGallery.h"


@implementation _ShopInfo











@dynamic home;



@dynamic shopList;






+(ShopInfo*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"ShopInfo" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(ShopInfo*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopInfo" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[ShopInfo alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryShopInfo:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfo"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(ShopInfo*) queryShopInfoObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopInfo"];
    
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
    NSArray *array=[_ShopInfo queryShopInfo:nil];
    
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

- (NSNumber*)dataType {
	[self willAccessValueForKey:@"dataType"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"dataType"];
	[self didAccessValueForKey:@"dataType"];
	return result;
}

- (void)setDataType:(NSNumber*)value {
	[self willChangeValueForKey:@"dataType"];
	[self setPrimitiveValue:value forKey:@"dataType"];
	[self didChangeValueForKey:@"dataType"];
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

- (NSString*)shopTypeText {
	[self willAccessValueForKey:@"shopTypeText"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"shopTypeText"];
	[self didAccessValueForKey:@"shopTypeText"];
	return result;
}

- (void)setShopTypeText:(NSString*)value {
	[self willChangeValueForKey:@"shopTypeText"];
	[self setPrimitiveValue:value forKey:@"shopTypeText"];
	[self didChangeValueForKey:@"shopTypeText"];
}

- (NSString*)telCall {
	[self willAccessValueForKey:@"telCall"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"telCall"];
	[self didAccessValueForKey:@"telCall"];
	return result;
}

- (void)setTelCall:(NSString*)value {
	[self willChangeValueForKey:@"telCall"];
	[self setPrimitiveValue:value forKey:@"telCall"];
	[self didChangeValueForKey:@"telCall"];
}

- (NSString*)telDisplay {
	[self willAccessValueForKey:@"telDisplay"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"telDisplay"];
	[self didAccessValueForKey:@"telDisplay"];
	return result;
}

- (void)setTelDisplay:(NSString*)value {
	[self willChangeValueForKey:@"telDisplay"];
	[self setPrimitiveValue:value forKey:@"telDisplay"];
	[self didChangeValueForKey:@"telDisplay"];
}

- (NSNumber*)totalComment {
	[self willAccessValueForKey:@"totalComment"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"totalComment"];
	[self didAccessValueForKey:@"totalComment"];
	return result;
}

- (void)setTotalComment:(NSNumber*)value {
	[self willChangeValueForKey:@"totalComment"];
	[self setPrimitiveValue:value forKey:@"totalComment"];
	[self didChangeValueForKey:@"totalComment"];
}

- (NSNumber*)totalLove {
	[self willAccessValueForKey:@"totalLove"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"totalLove"];
	[self didAccessValueForKey:@"totalLove"];
	return result;
}

- (void)setTotalLove:(NSNumber*)value {
	[self willChangeValueForKey:@"totalLove"];
	[self setPrimitiveValue:value forKey:@"totalLove"];
	[self didChangeValueForKey:@"totalLove"];
}

#pragma mark Relationships
    
#pragma mark Comments
- (NSSet*)comments {
	[self willAccessValueForKey:@"comments"];
	NSSet *result = [self primitiveValueForKey:@"comments"];
	[self didAccessValueForKey:@"comments"];
	return result;
}

-(NSArray*) commentsObjects
{
    NSSet *set=[self comments];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setComments:(NSSet*)value {
	[self willChangeValueForKey:@"comments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"comments"] setSet:value];
	[self didChangeValueForKey:@"comments" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addComments:(NSSet*)value {
	[self willChangeValueForKey:@"comments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"comments"] unionSet:value];
	[self didChangeValueForKey:@"comments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeComments:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"comments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"comments"] minusSet:value];
	[self didChangeValueForKey:@"comments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addCommentsObject:(ShopInfoComment*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"comments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"comments"] addObject:value];
	[self didChangeValueForKey:@"comments" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeCommentsObject:(ShopInfoComment*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"comments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"comments"] removeObject:value];
	[self didChangeValueForKey:@"comments" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllComments
{
    [self removeComments:self.comments];
}

- (NSMutableSet*)commentsSet {
	[self willAccessValueForKey:@"comments"];
	NSMutableSet *result = [self mutableSetValueForKey:@"comments"];
	[self didAccessValueForKey:@"comments"];
	return result;
}

#pragma mark Events
- (NSSet*)events {
	[self willAccessValueForKey:@"events"];
	NSSet *result = [self primitiveValueForKey:@"events"];
	[self didAccessValueForKey:@"events"];
	return result;
}

-(NSArray*) eventsObjects
{
    NSSet *set=[self events];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setEvents:(NSSet*)value {
	[self willChangeValueForKey:@"events" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"events"] setSet:value];
	[self didChangeValueForKey:@"events" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addEvents:(NSSet*)value {
	[self willChangeValueForKey:@"events" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"events"] unionSet:value];
	[self didChangeValueForKey:@"events" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeEvents:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"events" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"events"] minusSet:value];
	[self didChangeValueForKey:@"events" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addEventsObject:(ShopInfoEvent*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"events" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"events"] addObject:value];
	[self didChangeValueForKey:@"events" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeEventsObject:(ShopInfoEvent*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"events" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"events"] removeObject:value];
	[self didChangeValueForKey:@"events" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllEvents
{
    [self removeEvents:self.events];
}

- (NSMutableSet*)eventsSet {
	[self willAccessValueForKey:@"events"];
	NSMutableSet *result = [self mutableSetValueForKey:@"events"];
	[self didAccessValueForKey:@"events"];
	return result;
}

#pragma mark Galleries
- (NSSet*)galleries {
	[self willAccessValueForKey:@"galleries"];
	NSSet *result = [self primitiveValueForKey:@"galleries"];
	[self didAccessValueForKey:@"galleries"];
	return result;
}

-(NSArray*) galleriesObjects
{
    NSSet *set=[self galleries];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setGalleries:(NSSet*)value {
	[self willChangeValueForKey:@"galleries" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"galleries"] setSet:value];
	[self didChangeValueForKey:@"galleries" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addGalleries:(NSSet*)value {
	[self willChangeValueForKey:@"galleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"galleries"] unionSet:value];
	[self didChangeValueForKey:@"galleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeGalleries:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"galleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"galleries"] minusSet:value];
	[self didChangeValueForKey:@"galleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addGalleriesObject:(ShopInfoGallery*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"galleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"galleries"] addObject:value];
	[self didChangeValueForKey:@"galleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeGalleriesObject:(ShopInfoGallery*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"galleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"galleries"] removeObject:value];
	[self didChangeValueForKey:@"galleries" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllGalleries
{
    [self removeGalleries:self.galleries];
}

- (NSMutableSet*)galleriesSet {
	[self willAccessValueForKey:@"galleries"];
	NSMutableSet *result = [self mutableSetValueForKey:@"galleries"];
	[self didAccessValueForKey:@"galleries"];
	return result;
}

#pragma mark Home
- (HomeShop*)home {
	[self willAccessValueForKey:@"home"];
	HomeShop *result = [self primitiveValueForKey:@"home"];
	[self didAccessValueForKey:@"home"];
	return result;
}

#pragma mark ShopList
- (ShopInfoList*)shopList {
	[self willAccessValueForKey:@"shopList"];
	ShopInfoList *result = [self primitiveValueForKey:@"shopList"];
	[self didAccessValueForKey:@"shopList"];
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
	
- (void)addUserGalleriesObject:(ShopInfoUserGallery*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"userGalleries"] addObject:value];
	[self didChangeValueForKey:@"userGalleries" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeUserGalleriesObject:(ShopInfoUserGallery*)value {

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


#pragma mark Utility

-(void) revert
{
    [self.managedObjectContext refreshObject:self mergeChanges:false];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end