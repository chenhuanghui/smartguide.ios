//
//  HomeDataManager.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeDataManager;

@protocol HomeDataDelegate <NSObject>

-(void) homeDataFinished:(HomeDataManager*) dataManager;
-(void) homeDataFailed:(HomeDataManager*) dataManager;

@end

@interface HomeDataManager : NSObject

+(HomeDataManager*) manager;

-(void) requestData;
-(void) loadMore;
-(void) refreshData;

-(void) addObserver:(id<HomeDataDelegate>) obj;

@property (nonatomic, strong) NSMutableArray *homes;
@property (nonatomic, strong) NSMutableArray *observers;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int pageSize;
@property (nonatomic, assign) bool loadingMore;
@property (nonatomic, assign) bool refreshing;
@property (nonatomic, assign) bool canLoadMore;
@property (nonatomic, assign) bool canRefresh;

@end
