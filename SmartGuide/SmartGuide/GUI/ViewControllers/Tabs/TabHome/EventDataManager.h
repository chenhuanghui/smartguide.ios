//
//  EventDataManager.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EventDataManager;

@protocol EventDataDelegate <NSObject>

-(void) eventDataFinished:(EventDataManager*) dataManager;
-(void) eventDataFailed:(EventDataManager*) dataManager;

@end

@interface EventDataManager : NSObject

+(EventDataManager*) manager;

-(void) requestData;
-(void) loadMore;
-(void) refreshData;

-(void) addObserver:(id<EventDataDelegate>) obj;

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSMutableArray *observers;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int pageSize;
@property (nonatomic, assign) bool loadingMore;
@property (nonatomic, assign) bool refreshing;
@property (nonatomic, assign) bool canLoadMore;
@property (nonatomic, assign) bool canRefresh;

@end
