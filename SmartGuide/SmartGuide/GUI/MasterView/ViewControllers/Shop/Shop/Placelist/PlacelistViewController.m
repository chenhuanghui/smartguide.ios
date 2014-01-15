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
#import "PlacelistBGView.h"

@interface PlacelistViewController ()<PlacelistCreateCellDelegate,UITextFieldDelegate>
{
    enum PLACELIST_CREATE_CELL_MODE _createCellMode;
    __weak PlacelistBGView *bg1;
    __weak PlacelistBGView *bg2;
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
    
    [UserPlacelist markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    _tableFrame=table.frame;
    
    _createCellMode=PLACELIST_CREATE_CELL_SMALL;
    
    [table registerNib:[UINib nibWithNibName:[PlacelistHeaderCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlacelistHeaderCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[PlacelistCreateCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlacelistCreateCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[PlaceListInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlaceListInfoCell reuseIdentifier]];
    
    _page=-1;
    _isCanLoadMore=true;
    _isLoadingMore=false;
    _placelists=[NSMutableArray array];
    
    _isLoadingPlacelist=true;
    [self requestUserPlacelist];
    
    table.dataSource=self;
    table.delegate=self;
    
    [self reloadData];
}

-(NSArray *)registerNotifications
{
    return @[UIKeyboardWillShowNotification,UIKeyboardWillHideNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification])
    {
        if(_createCellMode==PLACELIST_CREATE_CELL_SMALL)
        {
            _createCellMode=PLACELIST_CREATE_CELL_DETAIL;
            
            
            float height=[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
            [table l_v_setH:_tableFrame.size.height-height];
            
            [table beginUpdates];
            
            PlacelistCreateCell *cell=(PlacelistCreateCell*)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell loadWithMode:_createCellMode];
            
            [table endUpdates];
            
            [table setContentOffset:CGPointMake(0, -1) animated:true];
            
            [UIView animateWithDuration:0.15f animations:^{
                CGRect rect=[table rectForSection:0];
                rect.size.height-=7;
                
                bg1.frame=rect;
                
                rect=[table rectForSection:1];
                bg2.frame=rect;
            } completion:^(BOOL finished) {
                PlacelistCreateCell *cell=(PlacelistCreateCell*)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                [cell focus];
            }];
            
        }
    }
    else if([notification.name isEqualToString:UIKeyboardWillHideNotification])
    {
        table.frame=_tableFrame;
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
    
    PlacelistBGView *bg=[[PlacelistBGView alloc] initWithFrame:rect];
    
    bg1=bg;
    
    [table insertSubview:bg atIndex:0];
    
    rect=[table rectForSection:1];
    
    bg=[[PlacelistBGView alloc] initWithFrame:rect];
    
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
        
        ASIOperationCreatePlacelist *ope=(ASIOperationCreatePlacelist*) operation;
        int status=ope.status;
        
        if(ope.message.length>0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:ope.message onOK:^{
                if(status==1)
                    [self.navigationController popViewControllerAnimated:true];
            }];
        }
        else if(status==1)
        {
            [self.navigationController popViewControllerAnimated:true];
        }
        
        _operationCreatePlacelist=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserPlacelist class]])
    {
        _isLoadingPlacelist=false;
        
        ASIOperationUserPlacelist *ope=(ASIOperationUserPlacelist*) operation;
        
        _placelists=[ope.userPlacelists mutableCopy];
        
        if(_shoplist)
        {
            for(UserPlacelist *place in _placelists)
            {
                if([place.arrayIDShops containsObject:[NSString stringWithFormat:@"%@",_shoplist.idShop]])
                {
                    place.isTicked=@(true);
                }
            }
            
            [[DataManager shareInstance] save];
        }
        
        _isCanLoadMore=_placelists.count==10;
        _isLoadingMore=false;
        _page++;
        
        [self reloadData];
        
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
                return [PlaceListInfoCell height];
            
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
                UserPlacelist *place=_placelists[indexPath.row-1];
                
                [cell loadWithUserPlace:place];
                
                if(indexPath.row==1)
                    [cell setCellPosition:CELL_POSITION_TOP];
                else if(indexPath.row==[tableView numberOfRowsInSection:1]-1)
                    [cell setCellPosition:CELL_POSITION_BOTTOM];
                else
                    [cell setCellPosition:CELL_POSITION_MIDDLE];
                
                return cell;
            }
            
            break;
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1 && indexPath.row>0)
    {
        PlaceListInfoCell *cell=(PlaceListInfoCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        if(_shoplist)
        {
            if([cell.place.arrayIDShops containsObject:[NSString stringWithFormat:@"%i",_shoplist.idShop.integerValue]])
            {
                return;
            }
        }
        
        
        cell.place.isTicked=@(!cell.place.isTicked.boolValue);
        
        [cell setIsTicked:cell.place.isTicked.boolValue];
    }
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    
    if(_shoplist)
    {
        NSString *idPlacelists=@"";
        
        for(UserPlacelist *place in _placelists)
        {
            if(place.hasChanges)
            {
                
            }
        }
    }
    
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
