// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Ads.h instead.

#import <CoreData/CoreData.h>

#define Ads_ClassName @"Ads"

#define Ads_Begin_date @"begin_date"
#define Ads_End_date @"end_date"
#define Ads_IdAds @"idAds"
#define Ads_Image @"image"
#define Ads_Image_url @"image_url"
#define Ads_Name @"name"
#define Ads_Url @"url"

@class Ads;

@interface _Ads : NSManagedObject

+(Ads*) insert;
+(Ads*) temporary;
+(NSArray*) queryAds:(NSPredicate*) predicate;
+(Ads*) queryAdsObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSString* begin_date;
@property (nonatomic, retain) NSString* end_date;
@property (nonatomic, retain) NSNumber* idAds;
@property (nonatomic, retain) NSData* image;
@property (nonatomic, retain) NSString* image_url;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* url;

#pragma mark Fetched property

    
#pragma mark Relationships


@end