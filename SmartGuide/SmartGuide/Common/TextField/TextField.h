//
//  TextField.h
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TEXTFIELD_LEFTVIEW_TYPE
{
    TEXTFIELD_LEFTVIEW_SEARCH=0,
    TEXTFIELD_LEFTVIEW_LOCATION=1,
    TEXTFIELD_LEFTVIEW_NONE=2,
};

enum TEXTFIELD_RIGHTVIEW_TYPE
{
    TEXTFIELD_RIGHTVIEW_CLEAR=0,
    TEXTFIELD_RIGHTVIEW_LOCATION=1,
    TEXTFIELD_RIGHTVIEW_NONE=2,
};

enum TEXTFIELD_DISPLAY_TYPE
{
    TEXTFIELD_DISPLAY_TYPE_SEARCH=0,
};

enum TEXTFIELD_REFRESH_STATE
{
    TEXTFIELD_REFRESH_STATE_NORMAL=0,
    TEXTFIELD_REFRESH_STATE_REFRESHING=1,
    TEXTFIELD_REFRESH_STATE_DONE=2
};

@class TextField;

@protocol TextFieldDelegate <UITextFieldDelegate>

@optional
-(void) textFieldTouchedRightView:(TextField*) textField;
-(void) textFieldTouchedLeftView:(TextField*) textField;

@end

@interface TextField : UITextField

@property (nonatomic, assign) enum TEXTFIELD_DISPLAY_TYPE displayType;
@property (nonatomic, assign) enum TEXTFIELD_LEFTVIEW_TYPE leftViewType;
@property (nonatomic, assign) enum TEXTFIELD_RIGHTVIEW_TYPE rightViewType;
@property (nonatomic, weak) IBOutlet id<TextFieldDelegate> delegate;

@end

@interface SearchTextField : TextField
{
    __weak UIImageView *imgvLeft;
    __weak UIImageView *imgvRight;
    __weak UIView *midView;
}

@end

@protocol TextFieldRefreshDelegate <TextFieldDelegate>

-(void) textFieldNeedRefresh:(TextField*) txt;
-(void) textFieldRefreshFinished:(TextField*) txt;

@end

@interface HomeTextField : SearchTextField
{
    __weak UIImageView *imgvRefresh;
    bool _isUserDragging;
    bool _isMarkRefreshDone;
    
    CGRect _txtFrame;
    float _distanceMinY_Y;
    float _startRotationY;
    NSString *_text;
}

-(void) tableDidScroll:(UITableView*) table;
-(void) tableDidEndDecelerating:(UITableView*) table;
-(void) tableDidEndDragging:(UITableView*) table willDecelerate:(BOOL) decelerate;
-(void) tableWillBeginDragging:(UITableView*) table;
-(void) markRefreshDone:(UITableView*) table;

@property (nonatomic, readonly) enum TEXTFIELD_REFRESH_STATE refreshState;
@property (nonatomic, weak) id<TextFieldRefreshDelegate> delegate;
@property (nonatomic, assign) float maximumWidth;
@property (nonatomic, assign) float minimumWidth;
@property (nonatomic, assign) float minimumY;

@end

@interface UserPromotionTextField : HomeTextField

@end