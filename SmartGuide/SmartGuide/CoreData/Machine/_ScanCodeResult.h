// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeResult.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ScanCodeResult_ClassName @"ScanCodeResult"

#define ScanCodeResult_Code @"code"
#define ScanCodeResult_DecodeType @"decodeType"
#define ScanCodeResult_RelatedStatus @"relatedStatus"

@class ScanCodeResult;
@class ScanCodeDecode;
@class ScanCodeRelatedContain;

@interface _ScanCodeResult : NSManagedObject

+(ScanCodeResult*) insert;
+(ScanCodeResult*) temporary;
+(NSArray*) queryScanCodeResult:(NSPredicate*) predicate;
+(ScanCodeResult*) queryScanCodeResultObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* code;
@property (nonatomic, retain) NSNumber* decodeType;
@property (nonatomic, retain) NSNumber* relatedStatus;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Decode
- (NSSet*) decode;
- (NSArray*) decodeObjects;
- (void) addDecode:(NSSet*)value;
- (void) removeDecode:(NSSet*)value;
- (void) addDecodeObject:(ScanCodeDecode*)value;
- (void) removeDecodeObject:(ScanCodeDecode*)value;
- (void) removeAllDecode;

#pragma mark RelatedContain
- (NSSet*) relatedContain;
- (NSArray*) relatedContainObjects;
- (void) addRelatedContain:(NSSet*)value;
- (void) removeRelatedContain:(NSSet*)value;
- (void) addRelatedContainObject:(ScanCodeRelatedContain*)value;
- (void) removeRelatedContainObject:(ScanCodeRelatedContain*)value;
- (void) removeAllRelatedContain;



#pragma mark Utility

-(void) revert;

@end