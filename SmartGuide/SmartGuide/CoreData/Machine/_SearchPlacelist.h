// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SearchPlacelist.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define SearchPlacelist_ClassName @"SearchPlacelist"

#define SearchPlacelist_AuthorAvatar @"authorAvatar"
#define SearchPlacelist_AuthorName @"authorName"
#define SearchPlacelist_Desc @"desc"
#define SearchPlacelist_IdAuthor @"idAuthor"
#define SearchPlacelist_IdPlacelist @"idPlacelist"
#define SearchPlacelist_Image @"image"
#define SearchPlacelist_LoveStatus @"loveStatus"
#define SearchPlacelist_NumOfView @"numOfView"
#define SearchPlacelist_Title @"title"

@class SearchPlacelist;

@interface _SearchPlacelist : NSManagedObject

+(SearchPlacelist*) insert;
+(SearchPlacelist*) temporary;
+(NSArray*) querySearchPlacelist:(NSPredicate*) predicate;
+(SearchPlacelist*) querySearchPlacelistObject:(NSPredicate*) predicate;
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



#pragma mark Utility

-(void) revert;

@end