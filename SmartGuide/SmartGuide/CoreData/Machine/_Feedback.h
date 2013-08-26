// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Feedback.h instead.

#import <CoreData/CoreData.h>

#define Feedback_ClassName @"Feedback"

#define Feedback_Content @"content"
#define Feedback_Created_at @"created_at"
#define Feedback_IdFeedback @"idFeedback"
#define Feedback_IdUser @"idUser"

@class Feedback;

@interface _Feedback : NSManagedObject

+(Feedback*) insert;
+(Feedback*) temporary;
+(NSArray*) queryFeedback:(NSPredicate*) predicate;
+(Feedback*) queryFeedbackObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* created_at;
@property (nonatomic, retain) NSNumber* idFeedback;
@property (nonatomic, retain) NSNumber* idUser;

#pragma mark Fetched property

    
#pragma mark Relationships


@end