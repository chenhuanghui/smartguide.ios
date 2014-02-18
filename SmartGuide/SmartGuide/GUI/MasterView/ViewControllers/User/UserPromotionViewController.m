//
//  UserPromotionViewController.m
//  SmartGuide
//
//  Created by MacMini on 17/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserPromotionViewController.h"

#define USER_PROMOTION_DELTA_SPEED 2.1f

@interface UserPromotionViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ASIOperationPostDelegate>

@end

@implementation UserPromotionViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"UserPromotionViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, txt.frame.size.height)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
//    [table l_v_addH:QRCODE_SMALL_HEIGHT*USER_PROMOTION_DELTA_SPEED];
    
    [table registerNib:[UINib nibWithNibName:[HomeInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeInfoCell reuseIdentifier]];
    
    _canLoadingMore=true;
    _isLoadingMore=false;
    _userPromotions=[NSMutableArray new];
    _page=-1;
    
    [self requestUserPromotion];
    
    [self.view showLoadingInsideFrame:CGRectMake(0, 54, self.view.l_v_w, self.view.l_v_h-54)];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return false;
}

-(void) requestUserPromotion
{
    _operationUserPromotion=[[ASIOperationUserPromotion alloc] initWithPage:_page+1 userLat:userLat() userLng:userLng()];
    _operationUserPromotion.delegatePost=self;
    
    [_operationUserPromotion startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnScanBigTouchUpInside:(id)sender {
}

- (IBAction)btnScanSmallTouchUpInside:(id)sender {
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    [self.delegate userPromotionTouchedNavigation:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _userPromotions.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userPromotions.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HomeInfoCell heightWithUserPromotion:_userPromotions[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeInfoCell reuseIdentifier]];
    
    [cell loadWithUserPromotion:_userPromotions[indexPath.row]];
    
    return cell;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserPromotion class]])
    {
        [self.view removeLoading];
        
        ASIOperationUserPromotion* ope=(ASIOperationUserPromotion*) operation;
        
        _isLoadingMore=false;
        _canLoadingMore=ope.userPromotions.count==10;
        _page++;
        
        [_userPromotions addObjectsFromArray:ope.userPromotions];
        
        if(ope.userPromotions.count>0)
            [table reloadData];
        
        _operationUserPromotion=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserPromotion class]])
    {
        [self.view removeLoading];
        
        _operationUserPromotion=nil;
    }
}

@end
