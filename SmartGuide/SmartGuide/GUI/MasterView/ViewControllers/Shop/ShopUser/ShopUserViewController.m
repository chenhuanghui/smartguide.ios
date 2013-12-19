//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"
#import "GUIManager.h"
#import "SGShopEmptyCell.h"

//Vị trí y của table
#define SHOP_USER_ANIMATION_ALIGN_Y 100.f

@interface ShopUserViewController ()

@end

@implementation ShopUserViewController
@synthesize delegate,shopMode;

- (id)init
{
    self = [super initWithNibName:@"ShopUserViewController" bundle:nil];
    if (self) {
        shopMode=SHOP_USER_FULL;
    }
    return self;
}

-(ShopUserViewController *)initWithShopList:(ShopList *)shopList
{
    self = [super initWithNibName:@"ShopUserViewController" bundle:nil];
    if (self) {
        shopMode=SHOP_USER_FULL;
        _shopList=[ShopList shopListWithIDShop:shopList.idShop.integerValue];
        _dataMode=SHOP_USER_DATA_SHOP_LIST;
    }
    return self;
}

- (IBAction)btnCloseTouchUpInside:(id)sender {
    [self.delegate shopUserFinished];
}

-(void) storeRect
{
    _btnNextFrame=btnNext.frame;
    _shopUserContentFrame=CGRectMake(0, 0, 290, 431);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect=CGRectZero;
    rect.origin=CGPointMake(15, 0);
    rect.size=CGSizeMake(290, 431);
    shopNavi.view.frame=rect;
    
    [detailView addSubview:shopNavi.view];
    detailView.receiveView=tableShopUser;
    
    [self storeRect];
    
    [tableShopUser registerNib:[UINib nibWithNibName:[SUShopGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUShopGalleryCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUKM1Cell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUInfoCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUUserGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUUserGalleryCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUUserCommentCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SGShopEmptyCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SGShopEmptyCell reuseIdentifier]];
    
    tableShopUser.dataSource=self;
    tableShopUser.delegate=self;
    
    switch (_dataMode) {
        case SHOP_USER_DATA_SHOP_LIST:
            tableShopUser.scrollEnabled=false;
            break;
            
        case SHOP_USER_DATA_SHOP_USER:
            break;
    }
    
    [tableShopUser reloadData];
    
    for(int i=0;i<[tableShopUser numberOfRowsInSection:0];i++)
    {
        [self tableView:tableShopUser cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopUserCommentKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    _operationShopUser=[[ASIOperationShopUser alloc] initWithIDShop:_shopList.idShop.integerValue userLat:userLat() userLng:userLng()];
    _operationShopUser.delegatePost=self;
    
    [_operationShopUser startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        ASIOperationShopUser *ope=(ASIOperationShopUser*)operation;
        
        _shop=ope.shop;
        
        _dataMode=SHOP_USER_DATA_SHOP_USER;
        
        [tableShopUser reloadData];
        tableShopUser.scrollEnabled=true;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

- (void)dealloc
{
    if(_operationShopUser)
    {
        [_operationShopUser cancel];
        _operationShopUser=nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    shopNavi=nil;
    shopGalleryCell=nil;
    km1Cell=nil;
    infoCell=nil;
    userGalleryCell=nil;
    userCommentCell=nil;
    _shop=nil;
}

-(void) shopUserCommentKeyboardWillShow:(NSNotification*) notification
{
    CGRect rect=[tableShopUser rectForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    rect.origin.y-=_btnNextFrame.size.height;
 
    if(tableShopUser.contentOffset.y<rect.origin.y)
    {
        [tableShopUser setContentOffset:CGPointMake(0, rect.origin.y) animated:true];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==tableShopUser)
    {
        if(shopGalleryCell)
        {
            [shopGalleryCell scrollViewDidScroll:tableShopUser];
        }
        
        float y=_btnNextFrame.origin.y+scrollView.contentOffset.y;
        y+=SHOP_USER_ANIMATION_ALIGN_Y;

        CGRect rect=[tableShopUser rectForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        
        if(y>=rect.origin.y)
        {
            y=-(y-rect.origin.y);
            
            y=MAX(0,_btnNextFrame.origin.y+y);
            [btnNext l_v_setY:y];
            
            [btnNext setImage:[UIImage imageNamed:@"button_dropup.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnNext l_v_setY:_btnNextFrame.origin.y];
            [btnNext setImage:[UIImage imageNamed:@"button_dropdown.png"] forState:UIControlStateNormal];
        }
        
        rect=[tableShopUser rectForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];

        if(shopUserCommentCell)
            [shopUserCommentCell tableDidScrollWithContentOffSetY:tableShopUser.contentOffset.y+_btnNextFrame.size.height+SHOP_USER_ANIMATION_ALIGN_Y cellContentY:rect.origin.y];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tableShopUser)
    {
        switch (_dataMode) {
            case SHOP_USER_DATA_SHOP_LIST:
                
                //shop gallery cell+loading cell
                return 2;
                
            case SHOP_USER_DATA_SHOP_USER:
                break;
        }
        
        int numOfRow=0;
        
        //shop gallery+logo+love+view+comment
        numOfRow++;
        //km1,km2,km3
        numOfRow++;
        
        //empty row, btnNext sẽ lấp vào khi table đang scroll
        numOfRow++;
        
        //shop info
        numOfRow++;
        
        //user gallery
        numOfRow++;
        
        //comments
        numOfRow++;
        
        return numOfRow;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableShopUser)
    {
        switch (indexPath.row) {
            case 0:
            {
                if(shopGalleryCell)
                    return shopGalleryCell;
                
                SUShopGalleryCell *cell=[tableView dequeueReusableCellWithIdentifier:[SUShopGalleryCell reuseIdentifier]];
                cell.delegate=self;
                
                switch (_dataMode) {
                    case SHOP_USER_DATA_SHOP_LIST:
                        [cell loadWithShopList:_shopList];
                        break;
                        
                    case SHOP_USER_DATA_SHOP_USER:
                        [cell loadWithShop:_shop];
                        break;
                }
                
                shopGalleryCell=cell;

                return cell;
            }
                
            case 1:
            {
                switch (_dataMode) {
                    case SHOP_USER_DATA_SHOP_LIST:
                    {
                        return [tableView dequeueReusableCellWithIdentifier:[SGShopEmptyCell reuseIdentifier]];
                    }
                        
                    default:
                        break;
                }
                
                if(km1Cell)
                    return km1Cell;
                
                SUKM1Cell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUKM1Cell reuseIdentifier]];
                
                [cell loadWithKM1:_shop.km1];
                
                km1Cell=cell;
                
                return cell;
            }
                
            case 2:
            {
                UITableViewCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:@"btnNext"];
                if(!cell)
                {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"btnNext"];
                    [cell l_v_setS:CGSizeMake(tableShopUser.l_v_w, _btnNextFrame.size.height)];
                }
             
                return cell;
            }
                
            case 3:
            {
                if(infoCell)
                    return infoCell;
                
                SUInfoCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUInfoCell reuseIdentifier]];
                
                cell.delegate=self;
                [cell loadWithShop:_shop];
                
                infoCell=cell;
                
                return cell;
            }
                
            case 4:
            {
                if(userGalleryCell)
                    return userGalleryCell;
                
                SUUserGalleryCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUUserGalleryCell reuseIdentifier]];
                
                cell.delegate=self;
                [cell loadWithShop:_shop];
                
                userGalleryCell=cell;
                
                return cell;
            }
                
            case 5:
            {
                if(userCommentCell)
                    return userCommentCell;
                
                SUUserCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:[SUUserCommentCell reuseIdentifier]];
                
                float maxHeight=_shopUserContentFrame.size.height-_btnNextFrame.size.height-[SUUserCommentCell tableY]+SHOP_USER_ANIMATION_ALIGN_Y;
                shopUserCommentCell=cell;
                
                [cell loadWithShop:_shop maxHeight:maxHeight];
                
                userCommentCell=cell;
                
                return cell;
            }
                
            default:
                break;
        }
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableShopUser)
    {
        switch (indexPath.row) {
            case 0:
                return [SUShopGalleryCell height];
            case 1:
            {
                switch (_dataMode) {
                    case SHOP_USER_DATA_SHOP_LIST:
                        
                        return [SGShopEmptyCell height];
                        
                    case SHOP_USER_DATA_SHOP_USER:
                        return [SUKM1Cell heightWithKM1:_shop.km1];
                }
            }
                
            case 2:
                return _btnNextFrame.size.height-4;
            case 3:
                return [SUInfoCell height];
            case 4:
                return [SUUserGalleryCell height];
            case 5:
                return [SUUserCommentCell heightWithShop:_shop];
                
            default:
                break;
        }
    }
    return 0;
}

-(void)suShopGalleryTouchedMoreInfo:(SUShopGalleryCell *)cell
{
    ShopDetailInfoViewController *vc=[ShopDetailInfoViewController new];
    
    [self pushViewController:vc];
}

-(void) pushViewController:(UIViewController*) vc
{
    btnBack.alpha=0;
    btnBack.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        btnBack.alpha=1;
    }];
    
    [shopNavi pushViewController:vc animated:true];
}

-(IBAction) btnNextTouchUpInside:(id)sender
{
    
}

-(void)userGalleryTouchedMakePicture:(SUUserGalleryCell *)cell
{
    ShopCameraViewController *vc=[ShopCameraViewController new];
    
    [self pushViewController:vc];
}

-(void)infoCellTouchedMap:(SUInfoCell *)cell
{
    ShopMapViewController *vc=[ShopMapViewController new];
    
    [self pushViewController:vc];
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    [shopNavi popToRootViewControllerAnimated:true];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        btnBack.alpha=0;
    } completion:^(BOOL finished) {
        btnBack.hidden=true;
    }];
}

@end

@implementation TableShopUser
@synthesize offset;

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(contentOffset.y+SHOP_USER_ANIMATION_ALIGN_Y<0)
        contentOffset.y=-SHOP_USER_ANIMATION_ALIGN_Y;
    
    offset=CGPointMake(contentOffset.x-self.contentOffset.x, contentOffset.y-self.contentOffset.y);
    
    [super setContentOffset:contentOffset];
}

@end