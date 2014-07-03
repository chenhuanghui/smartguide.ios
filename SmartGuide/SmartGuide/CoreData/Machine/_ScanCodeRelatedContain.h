// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeRelatedContain.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ScanCodeRelatedContain_ClassName @"ScanCodeRelatedContain"

#define ScanCodeRelatedContain_CanLoadMore @"canLoadMore"
#define ScanCodeRelatedContain_CurrentPage @"currentPage"
#define ScanCodeRelatedContain_IsLoadingMore @"isLoadingMore"
#define ScanCodeRelatedContain_Order @"order"
#define ScanCodeRelatedContain_Title @"title"
#define ScanCodeRelatedContain_Type @"type"

@class ScanCodeRelatedContain;
@class ScanCodeRelated;
@class ScanCodeResult;

@interface _ScanCodeRelatedContain : NSManagedObject

+(ScanCodeRelatedContain*) insert;
+(ScanCodeRelatedContain*) temporary;
+(NSArray*) queryScanCodeRelatedContain:(NSPredicate*) predicate;
+(ScanCodeRelatedContain*) queryScanCodeRelatedContainObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* canLoadMore;
@property (nonatomic, retain) NSNumber* currentPage;
@property (nonatomic, retain) NSNumber* isLoadingMore;
@property (nonatomic, retain) NSNumber* order;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSNumber* type;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Relaties
- (NSSet*) relaties;
- (NSArray*) relatiesObjects;
- (void) addRelaties:(NSSet*)value;
- (void) removeRelaties:(NSSet*)value;
- (void) addRelatiesObject:(ScanCodeRelated*)value;
- (void) removeRelatiesObject:(ScanCodeRelated*)value;
- (void) removeAllRelaties;

#pragma mark Result
@property (nonatomic, retain) ScanCodeResult* result;



#pragma mark Utility

-(void) revert;
-(void) save;

@end