//
//  ASIOperationGetAds.m
//  SmartGuide
//
//  Created by XXX on 8/8/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetAds.h"
#import "Ads.h"

@implementation ASIOperationGetAds
@synthesize arrAds;

-(ASIOperationGetAds *)initAds
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_ADS)];
    
    self=[super initWithURL:_url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    for(NSManagedObject *obj in [Ads allObjects])
        [[DataManager shareInstance].managedObjectContext deleteObject:obj];
    
    arrAds=[NSMutableArray array];
    if([self isNullData:json])
        return;
    
    if([[json objectAtIndex:0] isKindOfClass:[NSNumber class]] && [[json objectAtIndex:0] integerValue]==-1)
        return;
    
    for(NSDictionary *dict in json)
    {
        Ads *ad=[Ads insert];
        ad.idAds=[dict objectForKey:@"id"];
        
        ad.name=[NSString stringWithStringDefault:[dict objectForKey:@"name"]];
        ad.image_url=[NSString stringWithStringDefault:[dict objectForKey:@"image_url"]];
        ad.begin_date=[NSString stringWithStringDefault:[dict objectForKey:@"begin_date"]];
        ad.end_date=[NSString stringWithStringDefault:[dict objectForKey:@"end_date"]];
        ad.url=[NSString stringWithStringDefault:[dict objectForKey:@"url"]];
        
        [arrAds addObject:ad];
    }
    
    [[DataManager shareInstance] save];
}

@end
