//
//  DrawXXX.h
//  DrawSort
//
//  Created by MacMini on 26/11/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopSearchSortView;

@protocol SortSearchDelegate <NSObject>

-(void) sortViewTouchedSort:(ShopSearchSortView*) sortView;

@end

@interface ShopSearchSortView : UIView
{
    CGRect _touchedArea;
}

-(void) setIcon:(UIImage*) icon text:(NSString*) text;
-(void) setText:(NSString*) text;

@property (nonatomic, weak) id<SortSearchDelegate> delegate;

@end
