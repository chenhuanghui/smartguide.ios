//
//  SettingViewController.m
//  SmartGuide
//
//  Created by XXX on 7/17/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "Constant.h"
#import "UIImageView+AFNetworking.h"
#import "DataManager.h"
#import "Utility.h"
#import "LocationManager.h"
#import "Flags.h"
#import "AlphaView.h"
#import "BannerAdsViewController.h"
#import "FacebookManager.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init
{
    self = [super initWithNibName:NIB_PHONE(@"SettingViewController") bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([tableSetting respondsToSelector:@selector(setSeparatorInset:)])
        [tableSetting setSeparatorInset:UIEdgeInsetsZero];
    
    containView.backgroundColor=COLOR_BACKGROUND_APP;
    
    if(logoView)
        logoView.backgroundColor=COLOR_BACKGROUND_APP;
    
    CGRect rect=userView.frame;
    rect.size.height=[RootViewController shareInstance].bannerAds.view.frame.origin.y;
    userView.frame=rect;
    
    rect=editProfileView.frame;
    rect.size.height=[RootViewController shareInstance].bannerAds.view.frame.origin.y;
    editProfileView.frame=rect;
    
    _animationHeight=[RootViewController shareInstance].bannerAds.view.frame.origin.y-locationView.frame.origin.y;
    
    // Do any additional setup after loading the view from its nib.
    _settings=[[NSMutableArray alloc] init];
    
    //    SettingCellData *cell=[[SettingCellData alloc] init];
    //    cell.title=@"Nhận thông báo";
    //    cell.icon=[UIImage imageNamed:@"icon_notice.png"];
    //    [_settings addObject:cell];
    
    SettingCellData *cell=[[SettingCellData alloc] init];
    cell.title=@"Hướng dẫn sử dụng";
    cell.icon=[UIImage imageNamed:@"icon_shopmenu.png"];
    [_settings addObject:cell];
    
    cell=[[SettingCellData alloc] init];
    cell.title=@"Giới thiệu";
    cell.icon=[UIImage imageNamed:@"icon_intro.png"];
    [_settings addObject:cell];
    
    cell=[[SettingCellData alloc] init];
    cell.title=@"Cập nhật phiên bản";
    cell.icon=[UIImage imageNamed:@"icon_update.png"];
    [_settings addObject:cell];
    
    cell=[[SettingCellData alloc] init];
    cell.title=@"Đánh giá SmartGuide";
    cell.icon=[UIImage imageNamed:@"icon_report.png"];
    [_settings addObject:cell];
    
    [tableSetting registerNib:[UINib nibWithNibName:[SettingCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SettingCell reuseIdentifier]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActived:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self loadSetting];
}

-(void) appBecomeActived:(NSNotification*) notification
{
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    switchLocation.delegate=nil;
    switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
    switchLocation.delegate=self;
}

-(void)loadSetting
{
    btnFacebook.hidden=[DataManager shareInstance].currentUser.isConnectedFacebook.boolValue;
    
    lblCity.text=[DataManager shareInstance].currentCity.name;
    lblName.text=[DataManager shareInstance].currentUser.name;
    
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    switchLocation.delegate=nil;
    switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
    switchLocation.delegate=self;
}

-(void)switchChanged:(SwitchSetting *)sw
{
    if(sw.ON && ![LocationManager shareInstance].isAllowLocation)
    {
        [AlertView showAlertOKWithTitle:@"Thông báo" withMessage:@"Location services chưa được bật\nVào Setting/Privacy để kích hoạt chức năng này" onOK:^{
            switchLocation.delegate=nil;
            switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
            switchLocation.delegate=self;
        }];
    }
    else if(!sw.ON && [LocationManager shareInstance].isAllowLocation)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Location services đang được kích hoạt" onOK:^{
            switchLocation.delegate=nil;
            switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
            switchLocation.delegate=self;
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _settings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell=[tableView dequeueReusableCellWithIdentifier:[SettingCell reuseIdentifier]];
    
    [cell setData:[_settings objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SettingCell height];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCellData *data=[_settings objectAtIndex:indexPath.row];
    self.view.userInteractionEnabled=false;
    
    if([data.title isEqualToString:@"Đánh giá SmartGuide"])
    {
        _lockSlide=true;
        
        FeedbackView *fbv=[[FeedbackView alloc] init];
        fbv.alpha=0;
        fbv.delegate=self;
        
        [[RootViewController shareInstance].window addSubview:fbv];
        
        [UIView animateWithDuration:DURATION_SETTING animations:^{
            fbv.alpha=1;
        }];
    }
    else if([data.title isEqualToString:@"Hướng dẫn sử dụng"])
    {
        [Flurry trackUserClickTutorial];
        
        _lockSlide=true;
        
        TutorialView *tutorial=[[TutorialView alloc] init];
        
        tutorial.alpha=0;
        tutorial.delegate=self;
        
        [[RootViewController shareInstance].window addSubview:tutorial];
        
        [UIView animateWithDuration:DURATION_SETTING animations:^{
            tutorial.alpha=1;
        }];
    }
    else if([data.title isEqualToString:@"Giới thiệu"])
    {
        _lockSlide=true;
        
        IntroView *intro=[[IntroView alloc] init];
        
        intro.alpha=0;
        intro.delegate=self;
        
        [[RootViewController shareInstance].window addSubview:intro];
        
        [UIView animateWithDuration:DURATION_SETTING animations:^{
            intro.alpha=1;
        }];
    }
    else if([data.title isEqualToString:@"Cập nhật phiên bản"])
    {
        _lockSlide=true;
        
        UpdateVersion *uv=[[UpdateVersion alloc] init];
        
        uv.alpha=0;
        uv.delegate=self;
        
        [[RootViewController shareInstance].window addSubview:uv];
        
        [UIView animateWithDuration:DURATION_SETTING animations:^{
            uv.alpha=1;
        }];
    }
}

-(void)updateVersionClose:(UpdateVersion *)uv
{
    self.view.userInteractionEnabled=true;
    [UIView animateWithDuration:DURATION_SETTING animations:^{
        uv.alpha=0;
    } completion:^(BOOL finished) {
        uv.delegate=nil;
        [uv removeFromSuperview];
        
        _lockSlide=false;
    }];
}

-(void)introViewClose:(IntroView *)introView
{
    self.view.userInteractionEnabled=true;
    [UIView animateWithDuration:DURATION_SETTING animations:^{
        introView.alpha=0;
    } completion:^(BOOL finished) {
        introView.delegate=nil;
        [introView removeFromSuperview];
        
        _lockSlide=false;
    }];
}

-(void)tutorialViewBack:(TutorialView *)tutorial
{
    self.view.userInteractionEnabled=true;
    tutorial.userInteractionEnabled=false;
    [UIView animateWithDuration:DURATION_SETTING animations:^{
        tutorial.alpha=0;
    } completion:^(BOOL finished) {
        tutorial.delegate=nil;
        [tutorial removeFromSuperview];
        
        _lockSlide=false;
    }];
}

-(void)feedbackViewBack:(FeedbackView *)feedbackView
{
    self.view.userInteractionEnabled=true;
    
    feedbackView.userInteractionEnabled=false;
    [UIView animateWithDuration:DURATION_SETTING animations:^{
        feedbackView.alpha=0;
    } completion:^(BOOL finished) {
        feedbackView.delegate=nil;
        [feedbackView removeFromSuperview];
        
        _lockSlide=false;
    }];
}

- (void)viewDidUnload {
    tableSetting = nil;
    avatar = nil;
    switchLocation = nil;
    lblCity = nil;
    tableSetting = nil;
    containAvatar = nil;
    lblCity = nil;
    containView = nil;
    lblName = nil;
    [super viewDidUnload];
}

-(UITableView *)table
{
    return tableSetting;
}

-(bool)isLockSlide
{
    return _lockSlide;
}

-(void)onHideSetting
{
    if(avatarList.superview)
        [avatarList removeFromSuperview];
    
    avatarList=nil;
    
    [self resetEditProfile];
    [self hideEdit:false];
}

-(void) showEdit
{
    [self resetEditProfile];
    
    _isEditingProfile=true;
    editProfileView.alpha=0;
    editProfileView.hidden=false;
    
    [txtEditName setText:lblName.text];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        
        btnEditCancel.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45));
        
        lblName.alpha=0;
        editProfileView.alpha=1;
        
        CGPoint pnt=locationView.center;
        pnt.y+=_animationHeight;
        locationView.center=pnt;
        
        pnt=smartguideView.center;
        pnt.y+=_animationHeight;
        smartguideView.center=pnt;
        
        if(logoView)
        {
            pnt=logoView.center;
            pnt.y+=_animationHeight;
            logoView.center=pnt;
        }
    } completion:^(BOOL finished) {
        lblName.hidden=true;
    }];

}

-(void) hideEdit:(bool) animate
{
    if(!_isEditingProfile)
        return;
    
    [self.view endEditing:true];
    
    if(animate)
    {
        lblName.alpha=0;
        lblName.hidden=false;
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            
            btnEditCancel.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
            
            lblName.alpha=1;
            editProfileView.alpha=0;

            CGPoint pnt=locationView.center;
            pnt.y-=_animationHeight;
            locationView.center=pnt;
            
            pnt=smartguideView.center;
            pnt.y-=_animationHeight;
            smartguideView.center=pnt;
            
            if(logoView)
            {
                pnt=logoView.center;
                pnt.y-=_animationHeight;
                logoView.center=pnt;
            }
        } completion:^(BOOL finished) {
            editProfileView.hidden=true;
            _isEditingProfile=false;
        }];
    }
    else
    {
        btnEditCancel.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
        
        lblName.alpha=1;
        lblName.hidden=false;
        editProfileView.alpha=0;

        CGPoint pnt=locationView.center;
        pnt.y-=_animationHeight;
        locationView.center=pnt;
        
        pnt=smartguideView.center;
        pnt.y-=_animationHeight;
        smartguideView.center=pnt;
        
        if(logoView)
        {
            pnt=logoView.center;
            pnt.y-=_animationHeight;
            logoView.center=pnt;
        }
        
        editProfileView.hidden=true;
        _isEditingProfile=false;
    }
}

- (IBAction)btnEditProfileTouchUpInside:(id)sender
{
}

- (IBAction)btnEditAvatarTouchUpInside:(id)sender {
    
    _lockSlide=true;
    
    [self.view endEditing:true];
    
    CGRect rect=[UIScreen mainScreen].bounds;
    
    if(!avatarList)
    {
        avatarList=[[AvatarListView alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue frame:[UIScreen mainScreen].bounds];
        avatarList.avatarDelegate=self;
    }
    
    rect=CGRectMake(0, (rect.size.height-avatarList.contentHeight)/2, 320, avatarList.contentHeight);
    
    rect=CGRECT_PHONE(rect, CGRectMake(rect.origin.x, rect.origin.y+65, rect.size.width, rect.size.height-65*2));
    
    [self.view.window addSubview:avatarList];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        avatarList.alpha=1;
    }];
}

-(void) updateUserInfoWithName:(NSString*) name withAvatarURL:(NSString*) url
{
    ASIOperationUpdateUserInfo *operation=[[ASIOperationUpdateUserInfo alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue name:name avatar:url];
    
    operation.delegatePost=self;
    
    [operation startAsynchronous];
    
    [self.view.window showLoadingWithTitle:nil];
}

- (IBAction)btnEditCancelTouchUpInside:(id)sender {
    
    if(_isEditingProfile)
    {
        [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
        
        [self resetEditProfile];
        [self hideEdit:true];
    }
    else
    {
        [self showEdit];
    }
}

- (IBAction)btnEditUpdateTouchUpInside:(id)sender {
    NSString *name=[txtEditName.text stringByRemoveString:@" ",nil];
    
    if(_selectedAvatarLink.length==0)
        _selectedAvatarLink=[DataManager shareInstance].currentUser.avatar;
    
    if((name.length>0 && ![[txtEditName.text lowercaseString] isEqualToString:[lblName.text lowercaseString]])
       || ![_selectedAvatarLink isEqualToString:[DataManager shareInstance].currentUser.avatar])
    {
        _lockSlide=true;
        [self updateUserInfoWithName:txtEditName.text withAvatarURL:_selectedAvatarLink];
    }
    else
        [self hideEdit:true];
}

-(void)facebookLoginedSuccess:(NSNotification*) notification
{
    OperationFBGetProfile *getProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[FBSession activeSession].accessTokenData.accessToken];
    
    getProfile.delegate=self;
    [getProfile start];
    
    _lockSlide=true;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
    [self.view.window showLoadingWithTitle:nil];
}

- (IBAction)btnFacebookTouchUpInside:(id)sender
{
    [[FacebookManager shareInstance] login];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookLoginedSuccess:) name:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        OperationFBGetProfile *getProfile=(OperationFBGetProfile*) operation;
        
        ASIOperationFBProfile *postProfile=[[ASIOperationFBProfile alloc] initWithFBProfile:getProfile.profile];
        
        postProfile.delegatePost=self;
        [postProfile startAsynchronous];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    _lockSlide=false;
    [AlertView showAlertOKWithTitle:nil withMessage:@"Lỗi" onOK:nil];
}

-(void)avatarListSelectedItem:(AvatarListView *)avatarListView item:(NSString *)url image:(UIImage *)image
{
    _selectedAvatarLink=[[NSString alloc] initWithString:url];
    [avatar setImage:image];
    
    [self removeAvatarView];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUpdateUserInfo class]])
    {
        [self.view.window removeLoading];
        _lockSlide=false;
        
        ASIOperationUpdateUserInfo *ope=(ASIOperationUpdateUserInfo*)operation;
        
        if(ope.isSuccess)
        {
            lblName.text=txtEditName.text;
            
            [self resetEditProfile];
            [self hideEdit:true];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_UPDATED_INFO object:nil];
        }
        else
            [AlertView showAlertOKWithTitle:nil withMessage:localizeUpdateProfileFailed() onOK:nil];
    }
    else if([operation isKindOfClass:[ASIOperationFBProfile class]])
    {
        [self.view.window removeLoading];
        _lockSlide=false;
        
        ASIOperationFBProfile *ope=(ASIOperationFBProfile*)operation;
        if(ope.isSuccessed)
        {
            btnFacebook.hidden=true;
            
            lblName.text=[DataManager shareInstance].currentUser.name;
            [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
            
            [self resetEditProfile];
            [self hideEdit:true];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_UPDATED_INFO object:nil];
        }
        else
            [AlertView showAlertOKWithTitle:nil withMessage:localizeUpdateProfileFailed() onOK:nil];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self.view.window removeLoading];
    
    _lockSlide=false;
    [AlertView showAlertOKWithTitle:nil withMessage:localizeUpdateProfileFailed() onOK:nil];
}

-(void) resetEditProfile
{
    txtEditName.text=lblName.text;
    _selectedAvatarLink=@"";
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
}

-(void)avatarListSelectedEmptySpacing:(AvatarListView *)avatarListView
{
    [self removeAvatarView];
}

-(void) removeAvatarView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        avatarList.alpha=0;
    } completion:^(BOOL finished) {
        [avatarList removeFromSuperview];
        
        _lockSlide=false;
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}

-(BOOL)automaticallyAdjustsScrollViewInsets
{
    return true;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:true];
    return true;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.text=@"";
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text stringByRemoveString:@" ",nil].length==0)
    {
        textField.text=[DataManager shareInstance].currentUser.name;
    }
}

-(BOOL)wantsFullScreenLayout
{
    return true;
}

@end