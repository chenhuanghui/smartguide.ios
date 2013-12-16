//
//  ShopCategoriesViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedViewController.h"
#import "GUIManager.h"

@interface NewFeedViewController ()

@end

@implementation NewFeedViewController
@synthesize delegate,shopController,qrCodeView,isShowedQRView,qrViewFrame;

- (id)init
{
    self = [super initWithNibName:@"NewFeedViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.delegate shopCatalogSelectedCatalog:nil];
    return;
    for(UIView *group in [self groups])
    {
        UIButton *btn=[self groupButton:group];
        [btn addTarget:self action:@selector(btnGroupTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        btn=[self groupBadge:group];
        [btn setTitle:@"--" forState:UIControlStateNormal];
    }
    
    [self loadCatalog];
}

-(NSArray *)registerNotifications
{
    return @[UIApplicationDidBecomeActiveNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
        [self loadCatalog];
    }
}

-(void) btnGroupTouchUpInside:(UIButton*) btn
{
    UIView *groupView=btn.superview;
    
    ShopCatalog *group=[self groupWithView:groupView];
    [self.delegate shopCatalogSelectedCatalog:group];
    
    return;
    
    if(!group.isActived)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:localizeDanhMucHienKhongCoKhuyenMai() onOK:nil];
    }
    else
        [self.delegate shopCatalogSelectedCatalog:group];
}

-(ShopCatalog*) groupWithView:(UIView*) groupView
{
    if(groupView==groupFood)
        return [ShopCatalog catalogWithIDCatalog:1];
    else if(groupView==groupDrink)
        return [ShopCatalog catalogWithIDCatalog:2];
    else if(groupView==groupHealth)
        return [ShopCatalog catalogWithIDCatalog:3];
    else if(groupView==groupEntertaiment)
        return [ShopCatalog catalogWithIDCatalog:4];
    else if(groupView==groupFashion)
        return [ShopCatalog catalogWithIDCatalog:5];
    else if(groupView==groupTravel)
        return [ShopCatalog catalogWithIDCatalog:6];
    else if(groupView==groupProduction)
        return [ShopCatalog catalogWithIDCatalog:7];
    else if(groupView==groupEducation)
        return [ShopCatalog catalogWithIDCatalog:8];
    
    return [ShopCatalog all];
}

-(NSArray*) groups
{
    return @[groupAll,groupFood,groupDrink,groupHealth,groupEntertaiment,groupFashion,groupTravel,groupProduction,groupEducation];
}

-(UIView*) groupViewWithIDGroup:(int) idGroup
{
    switch (idGroup) {
        case 1:
            return groupFood;
        case 2:
            return groupDrink;
        case 3:
            return groupHealth;
        case 4:
            return groupEntertaiment;
        case 5:
            return groupFashion;
        case 6:
            return groupTravel;
        case 7:
            return groupProduction;
        case 8:
            return groupEducation;
            
        default:
            return groupAll;
    }
}

-(UIButton*) groupButton:(UIView*) group
{
    return (UIButton*)[group childViewWithTag:3];
}

-(UIButton*) groupBadge:(UIView*) group
{
    return (UIButton*)[group childViewWithTag:1];
}

-(UILabel*) groupTitle:(UIView*) group
{
    return (UILabel*)[group childViewWithTag:2];
}

-(void) loadCatalog
{
    if(_operationShopCatalog)
    {
        [_operationShopCatalog cancel];
        _operationShopCatalog=nil;
    }
    
    [DataManager shareInstance].currentCity=[City HCMCity];
    
    _operationShopCatalog=[[ASIOperationShopCatalog alloc] initWithIDCity:[DataManager shareInstance].currentCity.idCity];
    _operationShopCatalog.delegatePost=self;
    
    [_operationShopCatalog startAsynchronous];
    
    [self.view SGShowLoading];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    [self.view SGRemoveLoading];
    
    if([operation isKindOfClass:[ASIOperationShopCatalog class]])
    {
        ASIOperationShopCatalog *ope=(ASIOperationShopCatalog*) operation;
        
        if(ope.groupStatus==0)
        {
            [GUIManager shareInstance].mainWindow.userInteractionEnabled=false;

            UIImageView *imgv=nil;
            if(!_launchingView)
            {
                CGRect rect=CGRECT_PHONE(CGRectMake(0, 0, 320, 328), CGRectMake(0, 0, 320, 400));
                _launchingView=[[UIView alloc] initWithFrame:rect];
                _launchingView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
                _launchingView.alpha=0;
                
                imgv=[[UIImageView alloc] initWithFrame:rect];
                imgv.contentMode=UIViewContentModeScaleAspectFit;
                
                [_launchingView addSubview:imgv];
            }
            else
            {
                imgv=(UIImageView*)[_launchingView.subviews objectAtIndex:0];
            }
            
            imgv.image=nil;
            
            __weak UIImageView *_weakImgv=imgv;
            
            [imgv setImageWithLoading:[NSURL URLWithString:ope.groupUrl] emptyImage:nil success:^(UIImage *image) {
                _weakImgv.image=image;
                
                if(!_launchingView.superview)
                    [self.view addSubview:_launchingView];
                
                [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                    _launchingView.alpha=1;
                }];
            } failure:^(UIImage *emptyImage) {
                
            }];
        }
        else
        {
            if(_launchingView)
            {
                [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                    _launchingView.alpha=0;
                } completion:^(BOOL finished) {
                    [_launchingView removeFromSuperview];
                    _launchingView=nil;
                }];
                
                [GUIManager shareInstance].mainWindow.userInteractionEnabled=true;
            }
            
            for(ShopCatalog *group in ope.groups)
            {
                UIView *groupView=[self groupViewWithIDGroup:group.idCatalog.integerValue];
                
                UIButton *btn = [self groupBadge:groupView];
                int badge=group.count.integerValue;
                
                NSString *str=@"";
                if(badge>0)
                    str=[NSString stringWithFormat:@"%02d",badge];
                else
                    str=@"0";
                
                if(badge>99)
                    str=@"99+";
                
                [btn setTitle:str forState:UIControlStateNormal];
            }
        }
        
        _operationShopCatalog=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self.view SGRemoveLoading];
    _operationShopCatalog=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)title
{
    return CLASS_NAME;
}

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate shopCatalogSelectedCatalog:nil];
}

-(void)showQRView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [self.qrCodeView l_v_setO:CGPointZero];
    }];
}

-(void)hideQRView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [self.qrCodeView l_v_setO:CGPointMake(0, self.qrViewFrame.origin.y)];
    }];
}

@end
