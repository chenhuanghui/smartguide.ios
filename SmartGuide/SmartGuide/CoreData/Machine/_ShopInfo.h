// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfo.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ShopInfo_ClassName @"ShopInfo"

#define ShopInfo_Address @"address"
#define ShopInfo_City @"city"
#define ShopInfo_DataType @"dataType"
#define ShopInfo_Desc @"desc"
#define ShopInfo_IdShop @"idShop"
#define ShopInfo_Logo @"logo"
#define ShopInfo_LoveStatus @"loveStatus"
#define ShopInfo_Name @"name"
#define ShopInfo_NumOfComment @"numOfComment"
#define ShopInfo_NumOfLove @"numOfLove"
#define ShopInfo_NumOfView @"numOfView"
#define ShopInfo_ShopLat @"shopLat"
#define ShopInfo_ShopLng @"shopLng"
#define ShopInfo_ShopType @"shopType"
#define ShopInfo_ShopTypeText @"shopTypeText"
#define ShopInfo_TelCall @"telCall"
#define ShopInfo_TelDisplay @"telDisplay"
#define ShopInfo_TotalComment @"totalComment"
#define ShopInfo_TotalLove @"totalLove"

@class ShopInfo;
@class ShopInfoComment;
@class ShopInfoEvent;
@class ShopInfoGallery;
@class HomeShop;
@class ShopInfoList;
@class ShopInfoUserGallery;

@interface _ShopInfo : NSManagedObject

+(ShopInfo*) insert;
+(ShopInfo*) temporary;
+(NSArray*) queryShopInfo:(NSPredicate*) predicate;
+(ShopInfo*) queryShopInfoObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSNumber* dataType;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* loveStatus;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* numOfComment;
@property (nonatomic, retain) NSString* numOfLove;
@property (nonatomic, retain) NSString* numOfView;
@property (nonatomic, retain) NSNumber* shopLat;
@property (nonatomic, retain) NSNumber* shopLng;
@property (nonatomic, retain) NSNumber* shopType;
@property (nonatomic, retain) NSString* shopTypeText;
@property (nonatomic, retain) NSString* telCall;
@property (nonatomic, retain) NSString* telDisplay;
@property (nonatomic, retain) NSNumber* totalComment;
@property (nonatomic, retain) NSNumber* totalLove;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Comments
- (NSSet*) comments;
- (NSArray*) commentsObjects;
- (void) addComments:(NSSet*)value;
- (void) removeComments:(NSSet*)value;
- (void) addCommentsObject:(ShopInfoComment*)value;
- (void) removeCommentsObject:(ShopInfoComment*)value;
- (void) removeAllComments;

#pragma mark Events
- (NSSet*) events;
- (NSArray*) eventsObjects;
- (void) addEvents:(NSSet*)value;
- (void) removeEvents:(NSSet*)value;
- (void) addEventsObject:(ShopInfoEvent*)value;
- (void) removeEventsObject:(ShopInfoEvent*)value;
- (void) removeAllEvents;

#pragma mark Galleries
- (NSSet*) galleries;
- (NSArray*) galleriesObjects;
- (void) addGalleries:(NSSet*)value;
- (void) removeGalleries:(NSSet*)value;
- (void) addGalleriesObject:(ShopInfoGallery*)value;
- (void) removeGalleriesObject:(ShopInfoGallery*)value;
- (void) removeAllGalleries;

#pragma mark Home
@property (nonatomic, retain) HomeShop* home;

#pragma mark ShopList
@property (nonatomic, retain) ShopInfoList* shopList;

#pragma mark UserGalleries
- (NSSet*) userGalleries;
- (NSArray*) userGalleriesObjects;
- (void) addUserGalleries:(NSSet*)value;
- (void) removeUserGalleries:(NSSet*)value;
- (void) addUserGalleriesObject:(ShopInfoUserGallery*)value;
- (void) removeUserGalleriesObject:(ShopInfoUserGallery*)value;
- (void) removeAllUserGalleries;



#pragma mark Utility

-(void) revert;

@end