//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"
#import "GUIManager.h"
#import "SGShopLoadingCell.h"

#define SHOP_USER_SHOP_GALLERY_INDEX_PATH [NSIndexPath indexPathForRow:0 inSection:0]
#define SHOP_USER_PROMOTION_INDEX_PATH [NSIndexPath indexPathForRow:1 inSection:0]
#define SHOP_USER_PROMOTION_NEWS_INDEX_PATH [NSIndexPath indexPathForRow:2 inSection:0]
#define SHOP_USER_BUTTON_CONTAIN_INDEX_PATH [NSIndexPath indexPathForRow:3 inSection:0]
#define SHOP_USER_INFO_INDEX_PATH [NSIndexPath indexPathForRow:4 inSection:0]
#define SHOP_USER_USER_GALLERY_INDEX_PATH [NSIndexPath indexPathForRow:5 inSection:0]
#define SHOP_USER_USER_COMMENT_INDEX_PATH [NSIndexPath indexPathForRow:6 inSection:0]

@interface ShopUserViewController ()

@end

@implementation ShopUserViewController
@synthesize delegate,shopMode;

-(ShopUserViewController *)initWithShopUser:(Shop *)shop
{
    self = [super initWithNibName:@"ShopUserViewController" bundle:nil];
    if (self) {
        _shop=shop;
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
    _shopUserContentFrame=shopNavi.view.frame;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    [detailView addSubview:shopNavi.view];
    [shopNavi l_v_setS:detailView.l_v_s];
    
    [self storeRect];
    
    [tableShopUser registerNib:[UINib nibWithNibName:[SUShopGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUShopGalleryCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUKM1Cell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUKM2Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUKM2Cell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUKMNewsCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUKMNewsCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUInfoCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUUserGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUUserGalleryCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUUserCommentCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SGShopLoadingCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SGShopLoadingCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SGShopEmptyCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SGShopEmptyCell reuseIdentifier]];
    
    tableShopUser.dataSource=self;
    tableShopUser.delegate=self;
    
    switch (_shop.enumDataMode) {
        case SHOP_DATA_SHOP_LIST:
            tableShopUser.scrollEnabled=false;
            
            _operationShopUser=[[ASIOperationShopUser alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng()];
            _operationShopUser.delegatePost=self;
            
            [_operationShopUser startAsynchronous];
            
            break;
            
        case SHOP_DATA_FULL:
            
            _comments=[[NSMutableArray alloc] initWithArray:_shop.topCommentsObjects];
            
            _pageComment=0;
            _isLoadingMoreComment=false;
            _canLoadMoreComment=_comments.count==10;
            
            _sortComment=SORT_SHOP_COMMENT_TOP_AGREED;
            
            break;
            
        case SHOP_DATA_HOME_8:
            
            tableShopUser.scrollEnabled=false;
            
            _operationShopUser=[[ASIOperationShopUser alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng()];
            _operationShopUser.delegatePost=self;
            
            [_operationShopUser startAsynchronous];
            
            break;
    }
    
    [tableShopUser reloadData];
    
    for(int i=0;i<[tableShopUser numberOfRowsInSection:0];i++)
    {
        [self tableView:tableShopUser cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopUserCommentKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        ASIOperationShopUser *ope=(ASIOperationShopUser*)operation;
        
        _shop=ope.shop;
        shopGalleryCell=nil;
        
        _comments=[[NSMutableArray alloc] initWithArray:_shop.topCommentsObjects];
        
        _pageComment=0;
        _isLoadingMoreComment=false;
        _canLoadMoreComment=_comments.count==10;
        
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
        
        [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
        [userCommentCell l_v_setH:[tableShopUser rectForRowAtIndexPath:SHOP_USER_USER_COMMENT_INDEX_PATH].size.height];
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
            
            [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
            [self scrollViewDidScroll:tableShopUser];
            
            [self scrollToCommentCell:false showKeyboard:false];
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

-(void) scrollToCommentCell:(bool) animate showKeyboard:(bool) isShowKeyboard
{
    CGRect rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_USER_COMMENT_INDEX_PATH];
    float height=tableShopUser.l_co_y+tableShopUser.l_v_h-rect.origin.y;
    
    if(height<403)
    {
        rect.origin.y-=_btnNextFrame.size.height;
        rect.size.height=shopNavi.l_v_h;
        
        if(animate)
        {
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                [tableShopUser scrollRectToVisible:rect animated:false];
            } completion:^(BOOL finished) {
                if(isShowKeyboard)
                    [userCommentCell focus];
            }];
        }
        else
        {
            [tableShopUser scrollRectToVisible:rect animated:false];
            if(isShowKeyboard)
                [userCommentCell focus];
        }
    }
    else
    {
        if(animate)
        {
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                [tableShopUser l_co_addY:-userCommentCell.table.l_co_y animate:false];
            } completion:^(BOOL finished) {
                if(isShowKeyboard)
                    [userCommentCell focus];
            }];
        }
        else
        {
            [tableShopUser l_co_addY:-userCommentCell.table.l_co_y animate:false];
            if(isShowKeyboard)
                [userCommentCell focus];
        }
    }
}

-(void) shopUserCommentKeyboardWillShow:(NSNotification*) notification
{
    CGRect rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_USER_COMMENT_INDEX_PATH];
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

-(IBAction) btnNextTouchUpInside:(id)sender
{
    if(_shop.enumDataMode!=SHOP_DATA_FULL)
        return;
    
    CGRect rect=CGRectZero;
    float tableOffsetY=[self tableOffsetY];
    
    switch (_shop.enumPromotionType) {
        case SHOP_PROMOTION_KM1:
        case SHOP_PROMOTION_KM2:
            
            rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_PROMOTION_INDEX_PATH];
            
            //vị trí khuyến mãi chưa scroll đến top của màn hình
            if(tableOffsetY-rect.origin.y<0)
            {
                [self scrollToRowAtIndexPath:SHOP_USER_PROMOTION_INDEX_PATH animate:true];
            }
            else
            {
                // vùng hiển thị của khuyến mãi đã qua khỏi màn hình->scroll đến thông tin khuyến mãi
                if(tableOffsetY-rect.origin.y-rect.size.height>0)
                    [self scrollToRowAtIndexPath:SHOP_USER_PROMOTION_INDEX_PATH animate:true];
                else
                    [self scrollToInfoRow:true];
            }
            
            break;
            
        default:
            break;
    }
}

-(void) scrollToInfoRow:(bool) animate
{
    [self scrollToRowAtIndexPath:SHOP_USER_BUTTON_CONTAIN_INDEX_PATH animate:animate];
}

-(void) scrollToRowAtIndexPath:(NSIndexPath*) indexPath animate:(bool) animate
{
    CGRect rect=[tableShopUser rectForRowAtIndexPath:indexPath];
    rect.origin.y-=SHOP_USER_ANIMATION_ALIGN_Y;
    
    [tableShopUser l_co_setY:rect.origin.y animate:animate];
}

-(float) tableOffsetY
{
    return tableShopUser.l_co_y+SHOP_USER_ANIMATION_ALIGN_Y;
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
        
        CGRect rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_BUTTON_CONTAIN_INDEX_PATH];
        
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
        
        rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_USER_COMMENT_INDEX_PATH];
        
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
        switch (_shop.enumDataMode) {
            case SHOP_DATA_SHOP_LIST:
            case SHOP_DATA_HOME_8:
                
                //shop gallery cell+loading cell
                return 2;
                
            case SHOP_DATA_FULL:
            {
                int numOfRow=0;
                
                //shop gallery+logo+numOfLove+numOfView+numOfComment
                numOfRow++;
                
                //km0, km1, km2
                numOfRow++;
                
                //promotion news
                numOfRow++;
                
                //empty row phía trên shop info, btnNext sẽ lấp vào khi table đang scroll
                numOfRow++;
                
                //shop info
                numOfRow++;
                
                //user gallery
                numOfRow++;
                
                //comments
                numOfRow++;
                
                return numOfRow;
            }
        }
    }
    return 0;
}

-(SUShopGalleryCell*) shopGalleryCell
{
    if(shopGalleryCell)
        return shopGalleryCell;
    
    SUShopGalleryCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUShopGalleryCell reuseIdentifier]];
    cell.delegate=self;
    
    [cell loadWithShop:_shop];
    
    shopGalleryCell=cell;
    
    return cell;
}

-(SGShopLoadingCell*) loadingCell
{
    return [tableShopUser dequeueReusableCellWithIdentifier:[SGShopLoadingCell reuseIdentifier]];
}

-(SGShopEmptyCell*) emptyCell
{
    return [tableShopUser dequeueReusableCellWithIdentifier:[SGShopEmptyCell reuseIdentifier]];
}

-(SUKM1Cell*) km1Cell
{
    if(km1Cell)
        return km1Cell;
    
    SUKM1Cell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUKM1Cell reuseIdentifier]];
    
    [cell loadWithKM1:_shop.km1];
    
    km1Cell=cell;
    
    return cell;
}

-(SUKM2Cell*) km2Cell
{
    if(km2Cell)
        return km2Cell;
    
    SUKM2Cell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUKM2Cell reuseIdentifier]];
    
    [cell loadWithKM2:_shop.km2];
    
    km2Cell=cell;
    
    return cell;
}

-(SUKMNewsCell*) promotionNewsCell
{
    if(kmNewsCell)
        return kmNewsCell;
    
    SUKMNewsCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUKMNewsCell reuseIdentifier]];
    
    [cell loadWithPromotionNews:_shop.promotionNew];
    
    if(_shop.enumPromotionType!=SHOP_PROMOTION_NONE)
        [cell hideLine];
    
    kmNewsCell=cell;
    
    return cell;
}

-(UITableViewCell*) buttonNextContainCell
{
    UITableViewCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:@"btnNext"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"btnNext"];
        [cell l_v_setS:CGSizeMake(tableShopUser.l_v_w, _btnNextFrame.size.height)];
    }
    
    return cell;
}

-(SUInfoCell*) infoCell
{
    if(infoCell)
        return infoCell;
    
    SUInfoCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUInfoCell reuseIdentifier]];
    
    cell.delegate=self;
    [cell loadWithShop:_shop];
    
    infoCell=cell;
    
    return cell;
}

-(SUUserGalleryCell*) userGalleryCell
{
    if(userGalleryCell)
        return userGalleryCell;
    
    SUUserGalleryCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUUserGalleryCell reuseIdentifier]];
    
    cell.delegate=self;
    [cell loadWithShop:_shop];
    
    userGalleryCell=cell;
    
    return cell;
}

-(SUUserCommentCell*) userCommentCell
{
    if(userCommentCell)
    {
        return userCommentCell;
    }
    
    SUUserCommentCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUUserCommentCell reuseIdentifier]];
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableShopUser)
    {
        switch (_shop.enumDataMode) {
            case SHOP_DATA_HOME_8:
            case SHOP_DATA_SHOP_LIST:
                
                if(indexPath.row==0)
                    return [self shopGalleryCell];
                else
                    return [self loadingCell];
                
            case SHOP_DATA_FULL:
            {
                switch (indexPath.row) {
                    case 0:
                        return [self shopGalleryCell];
                        
                    case 1:
                    {
                        switch (_shop.enumPromotionType)
                        {
                            case SHOP_PROMOTION_NONE:
                                return [self emptyCell];
                                
                            case SHOP_PROMOTION_KM1:
                                return [self km1Cell];
                                
                            case SHOP_PROMOTION_KM2:
                                return [self km2Cell];
                        }
                    }
                        
                    case 2:
                    {
                        if(_shop.promotionNew)
                            return [self promotionNewsCell];
                        else
                            return [self emptyCell];
                    }
                        
                    case 3:
                        return [self buttonNextContainCell];
                        
                    case 4:
                        return [self infoCell];
                        
                    case 5:
                        return [self userGalleryCell];
                        
                    case 6:
                        return [self userCommentCell];
                        
                    default:
                        return [UITableViewCell new];
                }
            }
        }
    }
    
    return [UITableViewCell new];
}

-(void)userCommentChangeSort:(SUUserCommentCell *)cell sort:(enum SORT_SHOP_COMMENT)sort
{
    self.view.userInteractionEnabled=false;
    [UIView animateWithDuration:0.3f animations:^{
        [self scrollToCommentCell:false showKeyboard:false];
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
        switch (_shop.enumDataMode) {
            case SHOP_DATA_HOME_8:
            case SHOP_DATA_SHOP_LIST:
            {
                if(indexPath.row==0)
                    return [SUShopGalleryCell height];
                else
                    return [SGShopLoadingCell height];
            }
                
            case SHOP_DATA_FULL:
            {
                switch (indexPath.row) {
                    case 0:
                        return [SUShopGalleryCell height];
                        
                    case 1:
                    {
                        switch (_shop.enumPromotionType) {
                            case SHOP_PROMOTION_NONE:
                                return [SGShopEmptyCell height];
                                
                            case SHOP_PROMOTION_KM1:
                                return [SUKM1Cell heightWithKM1:_shop.km1];
                                
                            case SHOP_PROMOTION_KM2:
                                return [SUKM2Cell heightWithKM2:_shop.km2];
                        }
                    }
                        
                    case 2:
                    {
                        if(_shop.promotionNew)
                            return [SUKMNewsCell heightWithPromotionNews:_shop.promotionNew];
                        else
                            return [SGShopEmptyCell height];
                    }
                        
                    case 3:
                        return _btnNextFrame.size.height-4;
                        
                    case 4:
                        return [SUInfoCell height];
                        
                    case 5:
                        return [SUUserGalleryCell height];
                        
                    case 6:
                    {
                        float maxHeight=_shopUserContentFrame.size.height-_btnNextFrame.size.height-[SUUserCommentCell tableY]+SHOP_USER_ANIMATION_ALIGN_Y;
                        return [SUUserCommentCell heightWithComments:_comments maxHeight:maxHeight];
                    }
                        
                    default:
                        return 0;
                }
            }
        }
    }
    
    return 0;
}

-(void)suShopGalleryTouchedMoreInfo:(SUShopGalleryCell *)cell
{
    if(!_shop)
        return;
    
    ShopDetailInfoViewController *vc=nil;
    
    vc=[[ShopDetailInfoViewController alloc] initWithShop:_shop];
    
    [self pushViewController:vc];
}

-(void)suShopGalleryTouchedCover:(SUShopGalleryCell *)cell object:(ShopGallery *)gallery
{
    ShopGalleryViewController *vc=[[ShopGalleryViewController alloc] initWithShop:_shop withMode:SHOP_GALLERY_VIEW_SHOP];
    vc.delegate=self;
    
    _selectedShopGallery=gallery;
    
    [vc setSelectedGallery:_selectedShopGallery];
    
    [self pushViewController:vc];
}

-(void)shopGalleryTouchedGallery:(ShopGalleryViewController *)controller gallery:(id)gallery
{
    if([gallery isKindOfClass:[ShopGallery class]])
    {
        _selectedShopGallery=gallery;
    }
    else if([gallery isKindOfClass:[ShopUserGallery class]])
    {
        
    }
}

-(void) pushViewController:(UIViewController*) vc
{
    btnBack.alpha=0;
    btnBack.hidden=false;
    bgBack.alpha=0;
    bgBack.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        btnBack.alpha=1;
        bgBack.alpha=1;
    }];
    
    [shopNavi pushViewController:vc animated:true];
}

-(void)userGalleryTouchedMakePicture:(SUUserGalleryCell *)cell
{
    ShopCameraViewController *vc=[ShopCameraViewController new];
    
    [self pushViewController:vc];
}

-(void)infoCellTouchedMap:(SUInfoCell *)cell
{
    ShopMapViewController *vc=[[ShopMapViewController alloc] initWithShop:_shop];
    
    [self pushViewController:vc];
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    if([shopNavi.visibleViewController isKindOfClass:[ShopMapViewController class]])
    {
        [_shop setCoordinate:CLLocationCoordinate2DMake(-1, -1)];
    }
    
    [shopNavi popViewControllerAnimated:true];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        bgBack.alpha=0;
        btnBack.alpha=0;
    } completion:^(BOOL finished) {
        btnBack.hidden=true;
        bgBack.hidden=true;
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