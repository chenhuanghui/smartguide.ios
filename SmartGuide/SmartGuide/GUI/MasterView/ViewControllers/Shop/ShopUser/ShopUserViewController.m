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
        
        _topComments=[[NSMutableArray alloc] initWithArray:_shop.topCommentsObjects];
        _timeComments=[[NSMutableArray alloc] init];
        
        _pageTimeComment=-1;
        _pageTopComment=0;
        _isLoadingMoreTimeComment=false;
        _isLoadingMoreTopComment=false;
        _canLoadMoreTopComment=_topComments.count==10;
        _canLoadMoreTimeComment=true;
        
        _dataMode=SHOP_USER_DATA_SHOP_USER;
        _sortComment=SORT_SHOP_COMMENT_TOP_AGREED;
        
        [tableShopUser reloadData];
        tableShopUser.scrollEnabled=true;
        _allowCommentCellScrolling=true;
        
        for(int i=0;i<[tableShopUser numberOfRowsInSection:0];i++)
        {
            [self tableView:tableShopUser cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    else if([operation isKindOfClass:[ASIOperationShopComment class]])
    {
        ASIOperationShopComment *ope=(ASIOperationShopComment*)operation;
        
        bool scrollToCommentCell=false;
        
        switch (ope.sortComment) {
            case SORT_SHOP_COMMENT_TOP_AGREED:
            {
                [_topComments addObjectsFromArray:ope.comments];
                _canLoadMoreTopComment=ope.comments.count==10;
                _isLoadingMoreTopComment=false;
                _pageTopComment++;
                
                _operationShopTopComment=nil;

                [userCommentCell loadWithComments:_topComments sort:_sortComment maxHeight:-1];
                [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
                [self scrollViewDidScroll:tableShopUser];
            }
                break;
                
            case SORT_SHOP_COMMENT_TIME:
            {
                [_timeComments addObjectsFromArray:ope.comments];
                _canLoadMoreTimeComment=ope.comments.count==10;
                _isLoadingMoreTimeComment=false;
                _pageTimeComment++;
                
                _operationShopTimeComment=nil;
                
                if(_pageTimeComment==0)
                    scrollToCommentCell=true;
            }
                break;
        }
        
        if(scrollToCommentCell)
        {
            [self scrollToCommentCell:true];
        }
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
    
    if(_operationShopTimeComment)
    {
        [_operationShopTimeComment cancel];
        _operationShopTimeComment=nil;
    }
    
    if(_operationShopTopComment)
    {
        [_operationShopTopComment cancel];
        _operationShopTopComment=nil;
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
    //    float height=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect rect=[tableShopUser rectForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    
    if(tableShopUser.l_co_y+tableShopUser.l_v_h>rect.origin.y)
    {
        rect.origin.y-=_btnNextFrame.size.height;
        rect.size.height=shopNavi.l_v_h;
        [UIView animateWithDuration:duration animations:^{
            [tableShopUser scrollRectToVisible:rect animated:false];
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
        
        rect=[tableShopUser rectForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        
        if(userCommentCell && _allowCommentCellScrolling)
        {
            [userCommentCell tableDidScroll:tableShopUser cellRect:rect];
        }
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
                        [cell loadWithComments:_timeComments sort:_sortComment maxHeight:maxHeight];
                        break;
                        
                    case SORT_SHOP_COMMENT_TOP_AGREED:
                        [cell loadWithComments:_topComments sort:_sortComment maxHeight:maxHeight];
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

-(void) scrollToCommentCell:(bool) animate
{
    return;
    CGRect rect=[tableShopUser rectForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    
    rect.origin.y-=_btnNextFrame.size.height;
    rect.size.height=shopNavi.l_v_h;
    [tableShopUser scrollRectToVisible:rect animated:animate];
}

-(void)userCommentChangeSort:(SUUserCommentCell *)cell sort:(enum SORT_SHOP_COMMENT)sort
{
    _sortComment=sort;
    
    switch (_sortComment) {
        case SORT_SHOP_COMMENT_TIME:
        {
            if(!_markStartLoadTimeComment)
            {
                _markStartLoadTimeComment=true;
                
                userCommentCell=nil;
                
                [self requestComments];
            }
            else
            {
                userCommentCell=nil;
                
                //[tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
                
                [self scrollToCommentCell:true];
            }
        }
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
        {
            userCommentCell=nil;
            
            //[tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
            
            [self scrollToCommentCell:true];
        }
            break;
    }
}

-(void) requestComments
{
    switch (_sortComment) {
        case SORT_SHOP_COMMENT_TOP_AGREED:
        {
            _operationShopTopComment=[[ASIOperationShopComment alloc] initWithIDShop:_shop.idShop.integerValue page:_pageTopComment+1 sort:_sortComment];
            _operationShopTopComment.delegatePost=self;
            
            [_operationShopTopComment startAsynchronous];
        }
            break;
            
        case SORT_SHOP_COMMENT_TIME:
        {
            _operationShopTimeComment=[[ASIOperationShopComment alloc] initWithIDShop:_shop.idShop.integerValue page:_pageTimeComment+1 sort:_sortComment];
            _operationShopTimeComment.delegatePost=self;
            
            [_operationShopTimeComment startAsynchronous];
        }
            break;
    }
}

-(bool)userCommentCanLoadMore:(SUUserCommentCell *)cell
{
    return _sortComment==SORT_SHOP_COMMENT_TIME?_canLoadMoreTimeComment:_canLoadMoreTopComment;
}

-(void)userCommentLoadMore:(SUUserCommentCell *)cell
{
    switch (_sortComment) {
        case SORT_SHOP_COMMENT_TIME:
            
            if(_isLoadingMoreTimeComment)
                return;
            
            _isLoadingMoreTimeComment=true;
            
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            
            if(_isLoadingMoreTopComment)
                return;
            
            _isLoadingMoreTopComment=true;
            
            break;
    }
    
    [self requestComments];
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
                switch (_sortComment) {
                    case SORT_SHOP_COMMENT_TOP_AGREED:
                        return [SUUserCommentCell heightWithComments:_topComments maxHeight:shopNavi.l_v_h];
                        
                    case SORT_SHOP_COMMENT_TIME:
                        return [SUUserCommentCell heightWithComments:_timeComments maxHeight:shopNavi.l_v_h];
                }
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