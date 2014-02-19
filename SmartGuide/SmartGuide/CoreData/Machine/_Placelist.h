// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Placelist.h instead.

#import <CoreData/CoreData.h>

#define Placelist_ClassName @"Placelist"

#define Placelist_AuthorAvatar @"authorAvatar"
#define Placelist_AuthorName @"authorName"
#define Placelist_Desc @"desc"
#define Placelist_IdAuthor @"idAuthor"
#define Placelist_IdPlacelist @"idPlacelist"
#define Placelist_Image @"image"
#define Placelist_LoveStatus @"loveStatus"
#define Placelist_NumOfView @"numOfView"
#define Placelist_Title @"title"

@class Placelist;
@class UserHome3;
@class ShopList;

@interface _Placelist : NSManagedObject

+(Placelist*) insert;
+(Placelist*) temporary;
+(NSArray*) queryPlacelist:(NSPredicate*) predicate;
+(Placelist*) queryPlacelistObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* authorAvatar;
@property (nonatomic, retain) NSString* authorName;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idAuthor;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* loveStatus;
@property (nonatomic, retain) NSString* numOfView;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home3
- (NSSet*) home3;
- (NSArray*) home3Objects;
- (void) addHome3:(NSSet*)value;
- (void) removeHome3:(NSSet*)value;
- (void) addHome3Object:(UserHome3*)value;
- (void) removeHome3Object:(UserHome3*)value;
- (void) removeAllHome3;

#pragma mark ShopsList
- (NSSet*) shopsList;
- (NSArray*) shopsListObjects;
- (void) addShopsList:(NSSet*)value;
- (void) removeShopsList:(NSSet*)value;
- (void) addShopsListObject:(ShopList*)value;
- (void) removeShopsListObject:(ShopList*)value;
- (void) removeAllShopsList;



#pragma mark Utility

-(void) revert;

@end