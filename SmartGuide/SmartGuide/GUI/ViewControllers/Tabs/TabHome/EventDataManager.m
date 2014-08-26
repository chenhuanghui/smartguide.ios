//
//  EventDataManager.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "EventDataManager.h"
#import "OperationEvent.h"
#import "ObserverObject.h"

@interface EventDataManager()<ASIOperationPostDelegate>
{
    OperationEvent *_opeEvent;
}

@end

@implementation EventDataManager

+(EventDataManager *)manager
{
    return [EventDataManager new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page=0;
        self.pageSize=10;
        self.canLoadMore=false;
        self.canRefresh=true;
        self.events=[NSMutableArray array];
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
        [((id<EventDataDelegate>)obs.obj) eventDataFinished:self];
    }
}

-(void) callbackFailed
{
    [self clearObserver];
    
    for(ObserverObject *obs in self.observers)
    {
        [((id<EventDataDelegate>)obs.obj) eventDataFailed:self];
    }
}

-(void)addObserver:(id<EventDataDelegate>)obj
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
    if(_opeEvent)
    {
        [_opeEvent clearDelegatesAndCancel];
        _opeEvent=nil;
    }
    
    self.page=0;
    self.events=[NSMutableArray array];
    
    _opeEvent=[[OperationEvent alloc] initWithPage:self.page userLat:userLat() userLng:userLng()];
    _opeEvent.delegate=self;
    
    [_opeEvent addToQueue];
}

-(void)loadMore
{
    if(_loadingMore || _opeEvent)
        return;
    
    _loadingMore=true;
    
    _opeEvent=[[OperationEvent alloc] initWithPage:self.page+1 userLat:userLat() userLng:userLng()];
    _opeEvent.delegate=self;
    
    [_opeEvent addToQueue];
}

-(void)refreshData
{
    if(_refreshing)
        return;
    
    _refreshing=true;
    
    if(_opeEvent)
    {
        [_opeEvent clearDelegatesAndCancel];
        _opeEvent=nil;
    }
    
    self.page=0;
    _opeEvent=[[OperationEvent alloc] initWithPage:self.page userLat:userLat() userLng:userLng()];
    _opeEvent.delegate=self;
    
    [_opeEvent addToQueue];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if(_refreshing)
    {
        self.events=[NSMutableArray new];
    }
    
    OperationEvent *ope=(id)operation;
    
    [self.events addObjectsFromArray:ope.events];
    self.canLoadMore=ope.events.count>=self.pageSize;
    _loadingMore=false;
    _refreshing=false;
    self.page++;
    
    [self callbackFinished];
    _opeEvent=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    _refreshing=false;
    _loadingMore=false;
    
    [self callbackFailed];
    _opeEvent=nil;
}

- (void)dealloc
{
    [self.observers removeAllObjects];
    
    if(_opeEvent)
    {
        [_opeEvent clearDelegatesAndCancel];
        _opeEvent=nil;
    }
}

@end
