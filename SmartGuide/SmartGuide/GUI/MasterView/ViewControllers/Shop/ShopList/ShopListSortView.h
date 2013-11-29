//
//  DrawXXX.h
//  DrawSort
//
//  Created by MacMini on 26/11/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopListSortView;

@protocol SortViewDelegate <NSObject>

-(void) sortViewTouchedSort:(ShopListSortView*) sortView;

@end

@interface ShopListSortView : UIView
{
    CGRect _touchedArea;
}

-(void) setIcon:(UIImage*) icon text:(NSString*) text;

@property (nonatomic, weak) id<SortViewDelegate> delegate;

@end
