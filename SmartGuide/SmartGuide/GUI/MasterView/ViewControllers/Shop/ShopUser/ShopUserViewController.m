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

#define SHOP_USER_COMMENT_INDEX_PATH [NSIndexPath indexPathForRow:5 inSection:0]

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
        
        _comments=[[NSMutableArray alloc] initWithArray:_shop.topCommentsObjects];
        
        _pageComment=0;
        _isLoadingMoreComment=false;
        _canLoadMoreComment=_comments.count==10;
        
        _dataMode=SHOP_USER_DATA_SHOP_USER;
        _sortComment=SORT_SHOP_COMMENT_TOP_AGREED;
        
        [tableShopUser reloadData];
        tableShopUser.scrollEnabled=true;
        
        for(int i=0;i<[tableShopUser numberOfRowsInSection:0];i++)
        {
            [self tableView:tableShopUser cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    else if([operation isKindOfClass:[ASIOperationShopComment class]])
    {
        ASIOperationShopComment *ope=(ASIOperationShopComment*)operation;
        
        [_comments addObjectsFromArray:ope.comments];
        _canLoadMoreComment=ope.comments.count==10;
        _isLoadingMoreComment=false;
        _pageComment++;
        
        [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
        [userCommentCell l_v_setH:[tableShopUser rectForRowAtIndexPath:SHOP_USER_COMMENT_INDEX_PATH].size.height];
        [self scrollViewDidScroll:tableShopUser];
        [tableShopUser setContentOffset:tableShopUser.contentOffset animated:true];
        [userCommentCell loadWithComments:_comments sort:_sortComment maxHeight:-1];
        
        _operationShopComment=nil;
    }
    else if([operation isKindOfClass:[ASIOperationPostComment class]])
    {
        [self.view removeLoading];
        
        ASIOperationPostComment *ope=(ASIOperationPostComment*) operation;
        
        if(ope.status==1)
        {
            if(_comments.count>0)
                [_comments insertObject:ope.userComment atIndex:0];
            else
                [_comments addObject:ope.userComment];
            
            userCommentCell.hidden=true;
            userCommentCell=nil;
            
//            [userCommentCell loadWithComments:_comments sort:_sortComment maxHeight:-1];
            [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
//            [userCommentCell l_v_setH:[tableShopUser rectForRowAtIndexPath:SHOP_USER_COMMENT_INDEX_PATH].size.height];

            [self scrollViewDidScroll:tableShopUser];
            
            CGRect rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_COMMENT_INDEX_PATH];
            rect.origin.y-=[userCommentCell.table rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].size.height;
            rect.origin.y-=_btnNextFrame.size.height;

//            [tableShopUser setContentOffset:tableShopUser.contentOffset animated:true];
            
            
            [tableShopUser setContentOffset:rect.origin animated:true];
            userCommentCell.hidden=false;
        }
        
        _opeartionPostComment=nil;
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
    
    if(_operationShopComment)
    {
        [_operationShopComment cancel];
        _operationShopComment=nil;
    }
    
    if(_opeartionPostComment)
    {
        _opeartionPostComment.delegatePost=nil;
        _opeartionPostComment=nil;
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

-(void) scrollToCommentCell:(bool) animate
{
    CGRect rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_COMMENT_INDEX_PATH];
    
    rect.origin.y-=_btnNextFrame.size.height;
    rect.size.height=shopNavi.l_v_h;
    [tableShopUser scrollRectToVisible:rect animated:animate];
}

-(void) shopUserCommentKeyboardWillShow:(NSNotification*) notification
{
    CGRect rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_COMMENT_INDEX_PATH];
    float height=tableShopUser.l_co_y+tableShopUser.l_v_h-rect.origin.y;
    
    if(height<403)
    {
        rect.origin.y-=_btnNextFrame.size.height;
        rect.size.height=shopNavi.l_v_h;
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
           [tableShopUser scrollRectToVisible:rect animated:false];
        } completion:^(BOOL finished) {
            [userCommentCell focus];
        }];
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
        
        rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_COMMENT_INDEX_PATH];
        
        if(userCommentCell)
        {
            [userCommentCell tableDidScroll:tableShopUser cellRect:rect];
        }
        
        [self.view endEditing:true];
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
                {
                    return userCommentCell;
                }
                
                SUUserCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:[SUUserCommentCell reuseIdentifier]];
                
                float maxHeight=_shopUserContentFrame.size.height-_btnNextFrame.size.height-[SUUserCommentCell tableY]+SHOP_USER_ANIMATION_ALIGN_Y;
                
                switch (_sortComment) {
                    case SORT_SHOP_COMMENT_TIME:
                        [cell loadWithComments:_comments sort:_sortComment maxHeight:maxHeight];
                        break;
                        
                    case SORT_SHOP_COMMENT_TOP_AGREED:
                        [cell loadWithComments:_comments sort:_sortComment maxHeight:maxHeight];
                        break;
                }
                
                cell.delegate=self;
                
                userCommentCell=cell;
                
                return cell;
            }
                
            default:
                break;
        }
    }
    
    return nil;
}

-(void)userCommentChangeSort:(SUUserCommentCell *)cell sort:(enum SORT_SHOP_COMMENT)sort
{
    self.view.userInteractionEnabled=false;
    [UIView animateWithDuration:0.3f animations:^{
        [self scrollToCommentCell:false];
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
        _sortComment=sort;
        
        _comments=[NSMutableArray array];
        _pageComment=-1;
        
        [self requestComments];
    }];
}

-(void) requestComments
{
    _operationShopComment=[[ASIOperationShopComment alloc] initWithIDShop:_shop.idShop.integerValue page:_pageComment+1 sort:_sortComment];
    _operationShopComment.delegatePost=self;
    
    [_operationShopComment startAsynchronous];
}

-(bool)userCommentCanLoadMore:(SUUserCommentCell *)cell
{
    return _canLoadMoreComment;
}

-(void)userCommentLoadMore:(SUUserCommentCell *)cell
{
    if(_isLoadingMoreComment)
        return;
    
    _isLoadingMoreComment=true;
    
    [self requestComments];
}

-(void)userCommentUserComment:(SUUserCommentCell *)cell comment:(NSString *)comment isShareFacebook:(bool)isShare
{
    [self.view showLoading];
    
    _opeartionPostComment=[[ASIOperationPostComment alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() comment:comment sort:_sortComment];
    _opeartionPostComment.delegatePost=self;
    
    [_opeartionPostComment startAsynchronous];
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
            {
                float maxHeight=_shopUserContentFrame.size.height-_btnNextFrame.size.height-[SUUserCommentCell tableY]+SHOP_USER_ANIMATION_ALIGN_Y;
                return [SUUserCommentCell heightWithComments:_comments maxHeight:maxHeight];
            }
                
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