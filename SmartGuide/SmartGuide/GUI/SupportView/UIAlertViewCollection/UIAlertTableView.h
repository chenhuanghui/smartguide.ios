#import <UIKit/UIKit.h>

@class UIAlertView;

@interface UIAlertTableView : UIAlertView<UIAlertViewDelegate> {
    UIAlertView *alertView;
    
    UILabel *_lableTitle;
    void(^_onOK)();
    void(^_onCancel)();
    bool _isPrepare;
}

-(void)showOnOK:(void (^)())onOK onCancel:(void (^)())onCancel;
- (void)prepare;
-(void) alignControl;

@property (nonatomic, readonly) UITableView *tableAlertView;

@end