//
//  ASIOperationUserPromotion.h
//  SmartGuide
//
//  Created by MacMini on 17/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "UserPromotion.h"

@interface ASIOperationUserPromotion : ASIOperationPost

-(ASIOperationUserPromotion*) initWithPage:(int) page userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) NSMutableArray *userPromotions;

@end
