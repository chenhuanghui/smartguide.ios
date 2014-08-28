// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MessageSender.m instead.

#import "_MessageSender.h"
#import "MessageSender.h"

#import "DataManager.h"
#import "MessageList.h"


@implementation _MessageSender





+(MessageSender*) insert
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MessageSender" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
}

+(MessageSender*) temporary
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MessageSender" inManagedObjectContext:[DataManager shareInstance].managedObjectContext];
    return [[MessageSender alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSArray*) queryMessageSender:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MessageSender"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    return result?result:[NSArray array];
}

+(MessageSender*) queryMessageSenderObject:(NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MessageSender"];
    
    if(predicate)
        [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=[DataManager shareInstance].managedObjectContext;

    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(result && result.count>0)
        return [result objectAtIndex:0];

    return nil;
}

+(NSArray*) allObjects
{
    NSArray *array=[_MessageSender queryMessageSender:nil];
    
    if(array)
        return array;
    
    return [NSArray array];
}

+(void) markDeleteAllObjects
{
    for(NSManagedObject *obj in [self allObjects])
    {
        [[DataManager shareInstance].managedObjectContext deleteObject:obj];
    }
}

-(void) markDeleted
{
    [[DataManager shareInstance].managedObjectContext deleteObject:self];
}



- (NSString*)content {
	[self willAccessValueForKey:@"content"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"content"];
	[self didAccessValueForKey:@"content"];
	return result;
}

- (void)setContent:(NSString*)value {
	[self willChangeValueForKey:@"content"];
	[self setPrimitiveValue:value forKey:@"content"];
	[self didChangeValueForKey:@"content"];
}

- (NSNumber*)countAll {
	[self willAccessValueForKey:@"countAll"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"countAll"];
	[self didAccessValueForKey:@"countAll"];
	return result;
}

- (void)setCountAll:(NSNumber*)value {
	[self willChangeValueForKey:@"countAll"];
	[self setPrimitiveValue:value forKey:@"countAll"];
	[self didChangeValueForKey:@"countAll"];
}

- (NSNumber*)countRead {
	[self willAccessValueForKey:@"countRead"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"countRead"];
	[self didAccessValueForKey:@"countRead"];
	return result;
}

- (void)setCountRead:(NSNumber*)value {
	[self willChangeValueForKey:@"countRead"];
	[self setPrimitiveValue:value forKey:@"countRead"];
	[self didChangeValueForKey:@"countRead"];
}

- (NSNumber*)countUnread {
	[self willAccessValueForKey:@"countUnread"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"countUnread"];
	[self didAccessValueForKey:@"countUnread"];
	return result;
}

- (void)setCountUnread:(NSNumber*)value {
	[self willChangeValueForKey:@"countUnread"];
	[self setPrimitiveValue:value forKey:@"countUnread"];
	[self didChangeValueForKey:@"countUnread"];
}

- (NSNumber*)highlightUnread {
	[self willAccessValueForKey:@"highlightUnread"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"highlightUnread"];
	[self didAccessValueForKey:@"highlightUnread"];
	return result;
}

- (void)setHighlightUnread:(NSNumber*)value {
	[self willChangeValueForKey:@"highlightUnread"];
	[self setPrimitiveValue:value forKey:@"highlightUnread"];
	[self didChangeValueForKey:@"highlightUnread"];
}

- (NSNumber*)idMessageNewest {
	[self willAccessValueForKey:@"idMessageNewest"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idMessageNewest"];
	[self didAccessValueForKey:@"idMessageNewest"];
	return result;
}

- (void)setIdMessageNewest:(NSNumber*)value {
	[self willChangeValueForKey:@"idMessageNewest"];
	[self setPrimitiveValue:value forKey:@"idMessageNewest"];
	[self didChangeValueForKey:@"idMessageNewest"];
}

- (NSNumber*)idSender {
	[self willAccessValueForKey:@"idSender"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"idSender"];
	[self didAccessValueForKey:@"idSender"];
	return result;
}

- (void)setIdSender:(NSNumber*)value {
	[self willChangeValueForKey:@"idSender"];
	[self setPrimitiveValue:value forKey:@"idSender"];
	[self didChangeValueForKey:@"idSender"];
}

- (NSString*)numAll {
	[self willAccessValueForKey:@"numAll"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numAll"];
	[self didAccessValueForKey:@"numAll"];
	return result;
}

- (void)setNumAll:(NSString*)value {
	[self willChangeValueForKey:@"numAll"];
	[self setPrimitiveValue:value forKey:@"numAll"];
	[self didChangeValueForKey:@"numAll"];
}

- (NSString*)numRead {
	[self willAccessValueForKey:@"numRead"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numRead"];
	[self didAccessValueForKey:@"numRead"];
	return result;
}

- (void)setNumRead:(NSString*)value {
	[self willChangeValueForKey:@"numRead"];
	[self setPrimitiveValue:value forKey:@"numRead"];
	[self didChangeValueForKey:@"numRead"];
}

- (NSString*)numUnread {
	[self willAccessValueForKey:@"numUnread"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"numUnread"];
	[self didAccessValueForKey:@"numUnread"];
	return result;
}

- (void)setNumUnread:(NSString*)value {
	[self willChangeValueForKey:@"numUnread"];
	[self setPrimitiveValue:value forKey:@"numUnread"];
	[self didChangeValueForKey:@"numUnread"];
}

- (NSString*)sender {
	[self willAccessValueForKey:@"sender"];
	NSString* result = (NSString*)[self primitiveValueForKey:@"sender"];
	[self didAccessValueForKey:@"sender"];
	return result;
}

- (void)setSender:(NSString*)value {
	[self willChangeValueForKey:@"sender"];
	[self setPrimitiveValue:value forKey:@"sender"];
	[self didChangeValueForKey:@"sender"];
}

- (NSNumber*)status {
	[self willAccessValueForKey:@"status"];
	NSNumber* result = (NSNumber*)[self primitiveValueForKey:@"status"];
	[self didAccessValueForKey:@"status"];
	return result;
}

- (void)setStatus:(NSNumber*)value {
	[self willChangeValueForKey:@"status"];
	[self setPrimitiveValue:value forKey:@"status"];
	[self didChangeValueForKey:@"status"];
}

#pragma mark Relationships
    
#pragma mark Messages
- (NSSet*)messages {
	[self willAccessValueForKey:@"messages"];
	NSSet *result = [self primitiveValueForKey:@"messages"];
	[self didAccessValueForKey:@"messages"];
	return result;
}

-(NSArray*) messagesObjects
{
    NSSet *set=[self messages];
    if(set)
        return [set allObjects];
    
    return [NSArray array];
}

- (void)setMessages:(NSSet*)value {
	[self willChangeValueForKey:@"messages" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"messages"] setSet:value];
	[self didChangeValueForKey:@"messages" withSetMutation:NSKeyValueSetSetMutation usingObjects:value];
}

- (void)addMessages:(NSSet*)value {
	[self willChangeValueForKey:@"messages" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"messages"] unionSet:value];
	[self didChangeValueForKey:@"messages" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

-(void)removeMessages:(NSSet*)value {

    for(NSManagedObject *obj in value.allObjects)
        [self.managedObjectContext deleteObject:obj];

	[self willChangeValueForKey:@"messages" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
	[[self primitiveValueForKey:@"messages"] minusSet:value];
	[self didChangeValueForKey:@"messages" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}
	
- (void)addMessagesObject:(MessageList*)value {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"messages" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"messages"] addObject:value];
	[self didChangeValueForKey:@"messages" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeMessagesObject:(MessageList*)value {

    [self.managedObjectContext deleteObject:value];

	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	[self willChangeValueForKey:@"messages" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"messages"] removeObject:value];
	[self didChangeValueForKey:@"messages" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void) removeAllMessages
{
    [self removeMessages:self.messages];
}

- (NSMutableSet*)messagesSet {
	[self willAccessValueForKey:@"messages"];
	NSMutableSet *result = [self mutableSetValueForKey:@"messages"];
	[self didAccessValueForKey:@"messages"];
	return result;
}


#pragma mark Utility

-(void) revert
{
    [self.managedObjectContext refreshObject:self mergeChanges:false];
}

-(BOOL) hasChanges
{
    return self.changedValues.count>0;
}

@end