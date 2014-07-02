//
//  ScanResultRelatedHeadView.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PeekTitleView, ScanResultRelatedHeadView;

@protocol ScanResultRelatedHeadViewDelegate <NSObject>

-(void) scanResultRelatedHeadView:(ScanResultRelatedHeadView*) headView selectedIndex:(int) index;

@end

@interface ScanResultRelatedHeadView : UIView
{
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIView *titlesView;
    __weak PeekTitleView *peekTitle;
}

-(void) loadWithTitles:(NSArray*) titles;
-(void) setTitleIndex:(int) index animate:(bool) animate;
+(float) height;

@property (nonatomic, weak) id<ScanResultRelatedHeadViewDelegate> delegate;

@end