// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeResult.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ScanCodeResult_ClassName @"ScanCodeResult"

#define ScanCodeResult_Code @"code"

@class ScanCodeResult;
@class ScanCodeDecode;
@class ScanCodeRelated;

@interface _ScanCodeResult : NSManagedObject

+(ScanCodeResult*) insert;
+(ScanCodeResult*) temporary;
+(NSArray*) queryScanCodeResult:(NSPredicate*) predicate;
+(ScanCodeResult*) queryScanCodeResultObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* code;

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

#pragma mark Relaties
- (NSSet*) relaties;
- (NSArray*) relatiesObjects;
- (void) addRelaties:(NSSet*)value;
- (void) removeRelaties:(NSSet*)value;
- (void) addRelatiesObject:(ScanCodeRelated*)value;
- (void) removeRelatiesObject:(ScanCodeRelated*)value;
- (void) removeAllRelaties;



#pragma mark Utility

-(void) revert;

@end