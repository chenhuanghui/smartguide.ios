//
//  PlacelistViewController.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PlacelistViewController.h"
#import "PlacelistHeaderCell.h"
#import "PlacelistCreateCell.h"
#import "PlaceListInfoCell.h"

@interface PlacelistViewController ()<PlacelistCreateCellDelegate,UITextFieldDelegate>
{
    enum PLACELIST_CREATE_CELL_MODE _createCellMode;
    __weak UIView *bg1;
    __weak UIView *bg2;
}

@end

@implementation PlacelistViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"PlacelistViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(PlacelistViewController *)initWithShopList:(ShopList *)shoplist;
{
    self = [super initWithNibName:@"PlacelistViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _shoplist=shoplist;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _createCellMode=PLACELIST_CREATE_CELL_SMALL;
    
    [table registerNib:[UINib nibWithNibName:[PlacelistHeaderCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlacelistHeaderCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[PlacelistCreateCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlacelistCreateCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[PlaceListInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlaceListInfoCell reuseIdentifier]];
    
    _page=-1;
    _isCanLoadMore=true;
    _isLoadingMore=false;
    _placelists=[NSMutableArray array];
    
    [self requestUserPlacelist];
    
    table.dataSource=self;
    table.delegate=self;
    
    [self reloadData];
}

-(NSArray *)registerNotifications
{
    return @[UIKeyboardWillShowNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification])
    {
        if(_createCellMode==PLACELIST_CREATE_CELL_SMALL)
        {
            _createCellMode=PLACELIST_CREATE_CELL_DETAIL;
            
            [table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                CGRect rect=[table rectForSection:0];
                rect.size.height-=7;
                
                bg1.frame=rect;
            } completion:^(BOOL finished) {
                PlacelistCreateCell *cell=(PlacelistCreateCell*)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                [cell focus];
            }];

        }
    }
}

-(void)placelistCreateCellTouchedCreate:(PlacelistCreateCell *)cell name:(NSString *)name desc:(NSString *)desc
{
    NSString *idShops=[NSString stringWithFormat:@"%i",_shoplist.idShop.integerValue];
    _operationCreatePlacelist=[[ASIOperationCreatePlacelist alloc] initWithName:name desc:desc idShop:idShops userLat:userLat() userLng:userLng()];
    _operationCreatePlacelist.delegatePost=self;
    
    [_operationCreatePlacelist startAsynchronous];
    
    [self.view showLoading];
}

-(void) reloadData
{
    [table reloadData];
    
    if(bg1)
    {
        [bg1 removeFromSuperview];
        bg1=nil;
    }
    
    if(bg2)
    {
        [bg2 removeFromSuperview];
        bg2=nil;
    }
    
    CGRect rect=[table rectForSection:0];
    rect.size.height-=7;
    
    UIView *bg=[[UIView alloc] initWithFrame:rect];
    
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.cornerRadius=2;
    bg.layer.masksToBounds=true;
    
    bg1=bg;
    
    [table insertSubview:bg atIndex:0];
    
    rect=[table rectForSection:1];
    
    if([table numberOfRowsInSection:1]>1)
        rect.size.height-=7;
    
    bg=[[UIView alloc] initWithFrame:rect];
    
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.cornerRadius=2;
    bg.layer.masksToBounds=true;
    
    bg2=bg;
    
    [table insertSubview:bg atIndex:0];
}

-(void) requestUserPlacelist
{
    _operationUserPlacelist=[[ASIOperationUserPlacelist alloc] initWithUserLat:userLat() userLng:userLng() page:_page+1];
    _operationUserPlacelist.delegatePost=self;
    
    [_operationUserPlacelist startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationCreatePlacelist class]])
    {
        [self.view removeLoading];
        
        
        _operationCreatePlacelist=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserPlacelist class]])
    {
        _operationUserPlacelist=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationCreatePlacelist class]])
    {
        _operationCreatePlacelist=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserPlacelist class]])
    {
        _operationUserPlacelist=nil;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 2;
    else if(section==1)
        return _placelists.count+1;
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row==0)
                return [PlacelistHeaderCell height];
            else
                return [PlacelistCreateCell heightWithMode:_createCellMode];

        case 1:
            if(indexPath.row==0)
                return [PlacelistHeaderCell height];
            else
                return table.l_v_h-[table rectForSection:0].size.height-[PlacelistHeaderCell height];
            
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            
            if(indexPath.row==0)
            {
                PlacelistHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:[PlacelistHeaderCell reuseIdentifier]];
                
                [cell setHeader:@"Tạo placelist"];
                
                return cell;
            }
            else
            {
                PlacelistCreateCell *cell=[tableView dequeueReusableCellWithIdentifier:[PlacelistCreateCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithMode:_createCellMode];
                
                return cell;
            }
            
            break;
            
        case 1:
            
            if(indexPath.row==0)
            {
                PlacelistHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:[PlacelistHeaderCell reuseIdentifier]];
                
                [cell setHeader:@"Thêm vào placelist"];
                
                return cell;
            }
            else
            {
                PlaceListInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[PlaceListInfoCell reuseIdentifier]];
                
                return cell;
            }
            
            break;
    }
    
    return [UITableViewCell new];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return false;
}

@end
