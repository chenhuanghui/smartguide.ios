//
//  ImageResizedCache.h
//  Infory
//
//  Created by XXX on 4/4/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageResizedCache : NSManagedObject

@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * resizeMode;

@end
