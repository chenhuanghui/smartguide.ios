//
//  NavigationBarView.h
//  SmartGuide
//
//  Created by XXX on 7/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum NAVIGATIONBAR_ITEM {
    ITEM_SEARCH = 0,
    ITEM_SETTING = 1,
    ITEM_FILTER = 2,
    ITEM_COLLECTION = 3,
    ITEM_MAP = 4,
    ITEM_CATALOGUE = 5,
    ITEM_LIST = 6
    };

@protocol NavigationBarDelegate <NSObject>

-(void) navigationBarSearch:(UIButton*) sender;
-(void) navigationBarSetting:(UIButton*) sender;
-(void) navigationBarFilter:(UIButton*) sender;
-(void) navigationBarUserCollection:(UIButton*) sender;
-(void) navigationBarMap:(UIButton*) sender;
-(void) navigationBarCatalogue:(UIButton*) sender;
-(void) navigationBarList:(UIButton*) sender;

@end

@protocol  NavigationSearchDelegate <NSObject>

-(void) navigationSearchSearchClicked:(UITextField*) textfield;
-(void) navigationSearchCancel:(UITextField*) textField;

@end

@interface NavigationBarView : UIView<UITextFieldDelegate>
{
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIButton *btnSearch;
    __weak IBOutlet UIButton *btnFilter;
    __weak IBOutlet UIButton *btnAvatar;
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIButton *btnList;
    __weak IBOutlet UIView *containButtons;
    __weak IBOutlet UIView *searchView;
    __weak IBOutlet UITextField *txtSearch;
    __weak IBOutlet UIButton *btnCancel;
    
    
    NSString *_previousTitle;
}

-(IBAction) btnSettingTouchUpInside:(UIButton*) sender;
-(IBAction) btnSearchTouchUpInside:(UIButton*) sender;
-(IBAction) btnFilterTouchUpInside:(UIButton*) sender;
-(IBAction) btnAvatarTouchUpInside:(UIButton*) sender;
-(IBAction) btnMapTouchUpInside:(UIButton*) sender;
-(IBAction)btnListTouchUpInside:(UIButton *)sender;
-(void) showSearchWithDelegate:(id<NavigationSearchDelegate>) delegate;
-(void) setSearchKeyword:(NSString*) key;
-(void) hideSearch;
-(void) enableCancelButton;

-(void) showIconList;
-(void) showIconMap;

-(void) enableButton:(enum NAVIGATIONBAR_ITEM) button enabled:(bool) isEnable;

+(float) height;

@property (nonatomic, assign) id<NavigationBarDelegate> delegate;
@property (nonatomic, assign) id<NavigationSearchDelegate> searchDelegate;

@end
