//
//  EmptyDataView.h
//  SmartGuide
//
//  Created by MacMini on 21/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum EMPTY_DATA_ALIGN_TEXT {
    EMPTY_DATA_ALIGN_TEXT_MIDDLE = 0,
    EMPTY_DATA_ALIGN_TEXT_TOP = 1
    };

@interface EmptyDataView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@interface UIView(EmptyDataView)

-(EmptyDataView*) emptyDataView;
-(void) removeEmptyDataView;
-(void) showEmptyDataWithText:(NSString*) text align:(enum EMPTY_DATA_ALIGN_TEXT) contentMode;

-(UILabel*) emptyDataLabel;

@end