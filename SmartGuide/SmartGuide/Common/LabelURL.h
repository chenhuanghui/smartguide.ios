//
//  LabelURL.h
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"

@class LabelURL;

@protocol LabelURLDelegate <NSObject>

@optional
-(bool) lableURLWillOpenURL:(LabelURL*) label url:(NSURL*) url;

@end

@interface LabelURL : UILabel
{
    __weak FTCoreTextView *_textView;
}

@property (nonatomic, readonly) bool isURL;
@property (nonatomic, weak) id<LabelURLDelegate> delegate;

@end
