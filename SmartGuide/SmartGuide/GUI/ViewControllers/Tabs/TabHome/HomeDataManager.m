//
//  HomeDataManager.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeDataManager.h"
#import "OperationHome.h"
#import "ObserverObject.h"

@interface HomeDataManager()<ASIOperationPostDelegate>
{
    OperationHome *_opeHome;
}

@end

@implementation HomeDataManager

+(HomeDataManager *)manager
{
    return [HomeDataManager new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page=0;
        self.pageSize=10;
        self.canLoadMore=false;
        self.canRefresh=true;
        self.homes=[NSMutableArray array];
        self.observers=[NSMutableArray new];
    }
    return self;
}

-(void) clearObserver
{
    NSMutableArray *array=[NSMutableArray array];
    
    for(ObserverObject *obj in self.observers)
    {
        if(!obj.obj)
            [array addObject:obj];
    }
    
    [self.observers removeObjectsInArray:array];
}

-(void) callbackFinished
{
    [self clearObserver];
    
    for(ObserverObject *obs in self.observers)
    {
        [((id<HomeDataDelegate>)obs.obj) homeDataFinished:self];
    }
}

-(void) callbackFailed
{
    [self clearObserver];
    
    for(ObserverObject *obs in self.observers)
    {
        [((id<HomeDataDelegate>)obs.obj) homeDataFailed:self];
    }
}

-(void)addObserver:(id<HomeDataDelegate>)obj
{
    [self clearObserver];
    
    for(ObserverObject *obs in self.observers)
        if(obs.obj==obj)
            return;
    
    ObserverObject *obs=[ObserverObject new];
    obs.obj=obj;
    
    [self.observers addObject:obs];
}

-(void)requestData
{
    if(_opeHome)
    {
        [_opeHome clearDelegatesAndCancel];
        _opeHome=nil;
    }
    
    self.page=0;
    self.homes=[NSMutableArray array];
    
    _opeHome=[[OperationHome alloc] initWithPage:self.page userLat:userLat() userLng:userLng()];
    _opeHome.delegate=self;
    
    [_opeHome addToQueue];
}

-(void)loadMore
{
    if(_loadingMore || _opeHome)
        return;
    
    _loadingMore=true;
    
    _opeHome=[[OperationHome alloc] initWithPage:self.page+1 userLat:userLat() userLng:userLng()];
    _opeHome.delegate=self;
    
    [_opeHome addToQueue];
}

-(void)refreshData
{
    if(_refreshing)
        return;
    
    _refreshing=true;
    
    if(_opeHome)
    {
        [_opeHome clearDelegatesAndCancel];
        _opeHome=nil;
    }
    
    self.page=0;
    _opeHome=[[OperationHome alloc] initWithPage:self.page userLat:userLat() userLng:userLng()];
    _opeHome.delegate=self;
    
    [_opeHome addToQueue];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if(_refreshing)
    {
        self.homes=[NSMutableArray new];
    }
    
    OperationHome *ope=(id)operation;
    
    [self.homes addObjectsFromArray:ope.homes];
    self.canLoadMore=ope.homes.count>=self.pageSize;
    _loadingMore=false;
    _refreshing=false;
    self.page++;
    
    [self callbackFinished];
    _opeHome=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    _refreshing=false;
    _loadingMore=false;
    
    [self callbackFailed];
    _opeHome=nil;
}

-(void)dealloc
{
    [self.observers removeAllObjects];
    
    if(_opeHome)
    {
        [_opeHome clearDelegatesAndCancel];
        _opeHome=nil;
    }
}



@end