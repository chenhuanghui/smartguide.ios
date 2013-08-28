// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Feedback.h instead.

#import <CoreData/CoreData.h>

#define Feedback_ClassName @"Feedback"

#define Feedback_Content @"content"
#define Feedback_User @"user"

@class Feedback;

@interface _Feedback : NSManagedObject

+(Feedback*) insert;
+(Feedback*) temporary;
+(NSArray*) queryFeedback:(NSPredicate*) predicate;
+(Feedback*) queryFeedbackObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* user;

#pragma mark Fetched property

    
#pragma mark Relationships


@end