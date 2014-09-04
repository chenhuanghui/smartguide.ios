//
//  DataAPI.m
//  Infory
//
//  Created by XXX on 9/4/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "DataAPI.h"
#import "ASIOperationPost.h"

@interface DataAPI()<ASIOperationPostDelegate>

@end

@implementation DataAPI

+(instancetype)manager
{
    return [self new];
}

-(void)requestData
{
    if(self.currentOperation)
    {
        [self.currentOperation clearDelegatesAndCancel];
        self.currentOperation=nil;
    }
    
    _page=0;
    self.currentOperation=[self createOperationAtPage:_page];
    self.currentOperation.delegate=self;
    
    [self.currentOperation addToQueue];
}

-(void)loadMore
{
    if(_loadingMore || !_canLoadMore)
        return;
    
    _loadingMore=true;
    
    self.currentOperation=[self createOperationAtPage:_page];
    self.currentOperation.delegate=self;
    
    [self.currentOperation addToQueue];
}

-(void)cancelAllRequest
{
    [self.currentOperation clearDelegatesAndCancel];
    self.currentOperation=nil;
}

-(ASIOperationPost *)createOperationAtPage:(int)page
{
    return nil;
}

-(void)prepareDataWithOperation:(ASIOperationPost *)operation
{
    
}

-(void)addObserver:(id<DataAPIDelegate>)observer
{
    for(DataAPIObserver *obj in self.observer)
        if(obj.observer==observer)
            return;
    
    DataAPIObserver *obj=[DataAPIObserver new];
    obj.observer=observer;
    
    [_observer addObject:obj];
}

-(NSMutableArray *)observer
{
    if(!_observer)
        _observer=[NSMutableArray new];
    
    return _observer;
}

-(void) clearObserver
{
    NSMutableArray *array=[NSMutableArray array];
    
    for(DataAPIObserver *obj in _observer)
    {
        if(!obj.observer)
            [array addObject:obj];
    }
    
    [_observer removeObjectsInArray:array];
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if(self.page==0)
        self.objects=[NSMutableArray new];
    
    [self prepareDataWithOperation:operation];
    
    [self clearObserver];
    
    for(DataAPIObserver *obj in _observer)
    {
        [obj.observer dataAPIFinished:self];
    }
    
    self.currentOperation=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self clearObserver];
    
    for(DataAPIObserver *obj in _observer)
    {
        [obj.observer dataAPIFailed:self];
    }
    
    self.currentOperation=nil;
}

-(NSMutableArray *)objects
{
    if(!_objects)
        _objects=[NSMutableArray new];
    
    return _objects;
}

-(void)dealloc
{
    DLOG_DEBUG(@"dealloc %@", CLASS_NAME);
    
    [self.observer removeAllObjects];
    [self cancelAllRequest];
}

@end

@implementation DataAPIObserver
@end

#import "OperationHome.h"
#import "Home.h"
#import "HomeShop.h"

@implementation HomeDataAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize=10;
    }
    return self;
}

-(ASIOperationPost *)createOperationAtPage:(int)page
{
    return [[OperationHome alloc] initWithPage:page userLat:userLat() userLng:userLng()];
}

-(void)prepareDataWithOperation:(ASIOperationPost *)operation
{
    OperationHome *ope=(id)operation;
    
    [self.objects addObjectsFromArray:ope.homes];
    self.canLoadMore=ope.homes.count>=self.pageSize;
    self.loadingMore=false;

    self.page++;
}

-(NSArray *)objectsMap
{
    NSMutableArray *array=[NSMutableArray array];
    for(Home *obj in self.objects)
    {
        if(obj.homeShop)
            [array addObject:obj.homeShop];
    }
    
    return array;
}

@end

#import "OperationEvent.h"
#import "Event.h"

@implementation EventDataAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize=10;
    }
    return self;
}

-(ASIOperationPost *)createOperationAtPage:(int)page
{
    return [[OperationEvent alloc] initWithPage:page userLat:userLat() userLng:userLng()];
}

-(void)prepareDataWithOperation:(ASIOperationPost *)operation
{
    OperationEvent *ope=(id)operation;
    
    [self.objects addObjectsFromArray:ope.events];
    self.canLoadMore=ope.events.count>=self.pageSize;
    self.loadingMore=false;
    self.page++;
}

-(NSArray *)objectsMap
{
    NSMutableArray *array=[NSMutableArray array];
    
    for(Event *obj in self.objects)
    {
        if(obj.enumType==EVENT_TYPE_SHOP)
            [array addObject:obj];
    }
    
    return array;
}

@end