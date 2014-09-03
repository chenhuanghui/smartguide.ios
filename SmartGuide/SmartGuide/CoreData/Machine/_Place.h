// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Place.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define Place_ClassName @"Place"

#define Place_AuthorAvatar @"authorAvatar"
#define Place_AuthorName @"authorName"
#define Place_Desc @"desc"
#define Place_IdAuthor @"idAuthor"
#define Place_IdPlace @"idPlace"
#define Place_Image @"image"
#define Place_LoveStatus @"loveStatus"
#define Place_NumOfView @"numOfView"
#define Place_Title @"title"

@class Place;
@class ShopInfoList;

@interface _Place : NSManagedObject

+(Place*) insert;
+(Place*) temporary;
+(NSArray*) queryPlace:(NSPredicate*) predicate;
+(Place*) queryPlaceObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* authorAvatar;
@property (nonatomic, retain) NSString* authorName;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idAuthor;
@property (nonatomic, retain) NSNumber* idPlace;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* loveStatus;
@property (nonatomic, retain) NSString* numOfView;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shops
- (NSSet*) shops;
- (NSArray*) shopsObjects;
- (void) addShops:(NSSet*)value;
- (void) removeShops:(NSSet*)value;
- (void) addShopsObject:(ShopInfoList*)value;
- (void) removeShopsObject:(ShopInfoList*)value;
- (void) removeAllShops;



#pragma mark Utility

-(void) revert;

@end