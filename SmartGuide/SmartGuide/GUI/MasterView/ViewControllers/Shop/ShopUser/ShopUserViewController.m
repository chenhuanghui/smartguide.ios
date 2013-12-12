//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"
#import "GUIManager.h"

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
    
    [detailView addSubview:shopNavi.view];
    detailView.receiveView=tableShopUser;    
    
    CGRect rect=CGRectZero;
    rect.origin=CGPointMake(15, 0);
    rect.size=CGSizeMake(290, 431);
    shopNavi.view.frame=rect;
    shopNavi.view.layer.cornerRadius=8;
    shopNavi.view.layer.masksToBounds=true;
    
    [self storeRect];
    
    [tableShopUser registerNib:[UINib nibWithNibName:[SUShopGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUShopGalleryCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUKM1Cell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUInfoCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUUserGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUUserGalleryCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUUserCommentCell reuseIdentifier]];
    
    tableShopUser.dataSource=self;
    tableShopUser.delegate=self;
    
    _km1Data=[NSMutableArray new];
    for(int i=0;i<3;i++)
    {
        [_km1Data addObject:@"Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet"];
    }
    
    _comments=[NSMutableArray new];
    
    for(int i=0;i<10;i++)
    {
        [_comments addObject:@"Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet"];
    }
    
    [tableShopUser reloadData];
    
    for(int i=0;i<[tableShopUser numberOfRowsInSection:0];i++)
    {
        [tableShopUser cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopUserCommentKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    for(int i=0;i<[tableShopUser numberOfRowsInSection:0];i++)
    {
        [tableShopUser cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    shopNavi=nil;
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
                SUShopGalleryCell *cell=[tableView dequeueReusableCellWithIdentifier:[SUShopGalleryCell reuseIdentifier]];
                cell.delegate=self;
                
                shopGalleryCell=cell;
                
                return cell;
            }
                
            case 1:
            {
                SUKM1Cell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUKM1Cell reuseIdentifier]];
                
                [cell loadWithKM:_km1Data];
                
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
                SUInfoCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUInfoCell reuseIdentifier]];
                
                cell.delegate=self;
                
                return cell;
            }
                
            case 4:
            {
                SUUserGalleryCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUUserGalleryCell reuseIdentifier]];
                
                cell.delegate=self;
                
                return cell;
            }
                
            case 5:
            {
                SUUserCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:[SUUserCommentCell reuseIdentifier]];
                
                float maxHeight=_shopUserContentFrame.size.height-_btnNextFrame.size.height-[SUUserCommentCell tableY]+SHOP_USER_ANIMATION_ALIGN_Y;
                shopUserCommentCell=cell;
                
                [cell loadWithComments:_comments maxHeight:maxHeight];
                
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
                return [SUKM1Cell heightWithKM:_km1Data];
            case 2:
                return _btnNextFrame.size.height-4;
            case 3:
                return [SUInfoCell height];
            case 4:
                return [SUUserGalleryCell height];
            case 5:
                return [SUUserCommentCell heightWithComments:_comments];
                
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