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

@interface ShopUserViewController ()<SUKM1Delegate,SUKM2Delegate>
{
}

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

-(ShopUserViewController *)initWithIDShop:(int)idShop
{
    self=[super initWithNibName:@"ShopUserViewController" bundle:nil];
    
    _idShop=idShop;
    shopMode=SHOP_USER_FULL;
    _shop=[Shop makeWithIDShop:_idShop];
    
    if(_shop.hasChanges)
        [[DataManager shareInstance] save];
    
    return self;
}

- (IBAction)btnCloseTouchUpInside:(id)sender {
    [SGData shareInstance].fScreen=[ShopUserViewController screenCode];
    
    if(_shop)
        [[SGData shareInstance].fData setObject:_shop.idShop forKey:@"idShop"];
    
    [self.delegate shopUserFinished:self];
}

-(void) storeRect
{
    _shopUserContentFrame=shopNavi.view.frame;
}

-(void) registerCell
{
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [tableShopUser registerNib:[UINib nibWithNibName:[SGShopLoadingCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SGShopLoadingCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUShopGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUShopGalleryCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUInfoCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUUserGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUUserGalleryCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUUserCommentCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUKMNewsCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUKMNewsCell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUKM1Cell reuseIdentifier]];
    [tableShopUser registerNib:[UINib nibWithNibName:[SUKM2Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SUKM2Cell reuseIdentifier]];
    
    _btnNextFrame=btnNext.frame;
    
    [detailView addSubview:shopNavi.view];
    [shopNavi l_v_setS:detailView.l_v_s];
    
    switch (_shop.enumDataMode) {
        case SHOP_DATA_SHOP_LIST:
            tableShopUser.scrollEnabled=false;
            
            [self requestShopUser];
            
            break;
            
        case SHOP_DATA_FULL:
            
            _pageComment=0;
            _isLoadingMoreComment=false;
            _canLoadMoreComment=_shop.topCommentsObjects.count==10;
            
            _sortComment=SORT_SHOP_COMMENT_TOP_AGREED;
            
            [self requestShopUser];
            
            break;
            
        case SHOP_DATA_HOME_8:
            
            tableShopUser.scrollEnabled=false;
            
            [self requestShopUser];
            
            break;
            
        case SHOP_DATA_IDSHOP:
            tableShopUser.scrollEnabled=false;
            
            [self requestShopUser];
            break;
    }
    
    [self registerCell];
    
    [tableShopUser reloadData];
    
    [self loadCells];
    
    [SGData shareInstance].fScreen=[ShopUserViewController screenCode];
}

-(void) requestShopUser
{
    _operationShopUser=[[ASIOperationShopUser alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng()];
    _operationShopUser.delegatePost=self;
    
    [_operationShopUser startAsynchronous];
}

+(NSString *)screenCode
{
    return SCREEN_CODE_SHOP_USER;
}

-(NSArray *)registerNotifications
{
    return @[UIKeyboardWillShowNotification,UIKeyboardDidShowNotification,UIKeyboardWillHideNotification,UIKeyboardDidHideNotification];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _isDiplayView=false;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _isDiplayView=true;
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification])
    {
        if(!_isDiplayView)
            return;
        
        float duration=[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey];
        CGRect rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_USER_COMMENT_INDEX_PATH];
        float y=[self tableOffsetY];
        
        [userCommentCell switchToEditingModeAnimate:true duration:duration];
        
        if(y<rect.origin.y)
        {
            rect=[self rectForRowAtIndexPath:SHOP_USER_USER_COMMENT_INDEX_PATH];
            rect.origin.y-=[self buttonNextHeight];
            
            [tableShopUser l_co_setY:rect.origin.y animate:true];
        }
    }
    else if([notification.name isEqualToString:UIKeyboardWillHideNotification])
    {
        if(!_isDiplayView)
            return;
        
        float duration=[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey];
        [userCommentCell switchToNormailModeAnimate:true duration:duration];
    }
    else if([notification.name isEqualToString:UIKeyboardDidShowNotification])
    {
        if(!_isDiplayView)
            return;
        
        _isKeyboardShowed=true;
    }
    else if([notification.name isEqualToString:UIKeyboardDidHideNotification])
    {
        if(!_isDiplayView)
            return;
        
        _isKeyboardShowed=false;
    }
}

-(void) loadCells
{
    for(int i=0;i<[tableShopUser numberOfRowsInSection:0];i++)
    {
        [self tableView:tableShopUser cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        ASIOperationShopUser *ope=(ASIOperationShopUser*)operation;
        
        _shop=ope.shop;
        shopGalleryCell=nil;
        
        _pageComment=0;
        _isLoadingMoreComment=false;
        _canLoadMoreComment=_shop.topCommentsObjects.count==10;
        
        _sortComment=SORT_SHOP_COMMENT_TOP_AGREED;
        
        [self registerCell];
        [tableShopUser reloadData];
        tableShopUser.scrollEnabled=true;
        
        [self loadCells];
        
        [self scrollViewDidScroll:tableShopUser];
    }
    else if([operation isKindOfClass:[ASIOperationShopComment class]])
    {
        self.view.userInteractionEnabled=true;
        [detailView removeLoading];
        
        ASIOperationShopComment *ope=(ASIOperationShopComment*)operation;
        
        _canLoadMoreComment=ope.comments.count==10;
        _isLoadingMoreComment=false;
        _pageComment++;
        
        if(_pageComment==0)
        {
            self.view.userInteractionEnabled=false;
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                userCommentCell.table.alpha=0.5f;
            } completion:^(BOOL finished) {
                [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
                [userCommentCell l_v_setH:[tableShopUser rectForRowAtIndexPath:SHOP_USER_USER_COMMENT_INDEX_PATH].size.height];
                [self scrollViewDidScroll:tableShopUser];
                [tableShopUser setContentOffset:tableShopUser.contentOffset animated:true];
                [userCommentCell loadWithShop:_shop sort:_sortComment maxHeight:-1];
                
                [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                    userCommentCell.table.alpha=1;
                } completion:^(BOOL finished) {
                    self.view.userInteractionEnabled=true;
                }];
            }];
        }
        else
        {
            [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
            [userCommentCell l_v_setH:[tableShopUser rectForRowAtIndexPath:SHOP_USER_USER_COMMENT_INDEX_PATH].size.height];
            [self scrollViewDidScroll:tableShopUser];
            [tableShopUser setContentOffset:tableShopUser.contentOffset animated:true];
            [userCommentCell loadWithShop:_shop sort:_sortComment maxHeight:-1];
        }
        
        _operationShopComment=nil;
    }
    else if([operation isKindOfClass:[ASIOperationPostComment class]])
    {
        [self.view removeLoading];
        
        ASIOperationPostComment *ope=(ASIOperationPostComment*) operation;
        
        if(ope.status==1)
        {
            [userCommentCell endEditing:true];
            [userCommentCell clearInput];
            userCommentCell.hidden=true;
            userCommentCell=nil;
            
            [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_USER_COMMENT_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
            [self scrollViewDidScroll:tableShopUser];
            
            [self scrollToCommentCell:false showKeyboard:false];
        }
        
        _opeartionPostComment=nil;
    }
    else if([operation isKindOfClass:[ASIOperationSocialShare class]])
    {
        ASIOperationSocialShare *ope=(ASIOperationSocialShare*)operation;
        
        if(ope.status==0)
            [[FacebookManager shareInstance] markNeedPermissionPostToWall];
        
        _operationSocialShare=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

- (void)dealloc
{
    if(_operationShopUser)
    {
        [_operationShopUser clearDelegatesAndCancel];
        _operationShopUser=nil;
    }
    
    if(_operationShopComment)
    {
        [_operationShopComment clearDelegatesAndCancel];
        _operationShopComment=nil;
    }
    
    if(_opeartionPostComment)
    {
        [_opeartionPostComment clearDelegatesAndCancel];
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
    float y=[self tableOffsetY];
    
    if(y<rect.origin.y)
    {
        rect.origin.y-=[self buttonNextHeight];
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
                [tableShopUser l_co_addY:-userCommentCell.table.l_co_y-userCommentCell.table.contentInset.top animate:false];
            } completion:^(BOOL finished) {
                if(isShowKeyboard)
                    [userCommentCell focus];
            }];
        }
        else
        {
            [tableShopUser l_co_addY:-userCommentCell.table.l_co_y-userCommentCell.table.contentInset.top animate:false];
            if(isShowKeyboard)
                [userCommentCell focus];
        }
    }
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    [self.view endEditing:true];
}

-(IBAction) btnNextTouchUpInside:(id)sender
{
    if(_shop.enumDataMode!=SHOP_DATA_FULL)
        return;
    
    CGRect rect=CGRectZero;
    float tableOffsetY=[self tableOffsetY];
    float btnHeight=[self buttonContainHeight];
    
    rect=[tableShopUser rectForRowAtIndexPath:SHOP_USER_INFO_INDEX_PATH];
    
    float y=tableOffsetY-rect.origin.y+btnHeight;
    
    //vị trí khuyến mãi chưa scroll đến top của màn hình
    if((int)y<0)
    {
        [self scrollToInfoRow:true];
    }
    else
    {
        y=tableOffsetY-rect.origin.y-rect.size.height-btnHeight;
        // vùng hiển thị của khuyến mãi đã qua khỏi màn hình->scroll đến thông tin khuyến mãi
        if(y<0)
            [self scrollToInfoRow:true];
        else
            [self scrollToTop:true];
    }
    
    return;
}

-(void) scrollToTop:(bool) animate
{
    [self scrollToRowAtIndexPath:SHOP_USER_SHOP_GALLERY_INDEX_PATH animate:animate];
}

-(void) scrollToInfoRow:(bool) animate
{
    [self scrollToRowAtIndexPath:SHOP_USER_BUTTON_CONTAIN_INDEX_PATH animate:animate];
}

-(void) scrollToRowAtIndexPath:(NSIndexPath*) indexPath animate:(bool) animate
{
    CGRect rect=[self rectForRowAtIndexPath:indexPath];
    
    [tableShopUser l_co_setY:rect.origin.y animate:animate];
}

-(CGRect) rectForRowAtIndexPath:(NSIndexPath*) indexPath
{
    CGRect rect=[tableShopUser rectForRowAtIndexPath:indexPath];
    rect.origin.y-=SHOP_USER_ANIMATION_ALIGN_Y;
    
    return rect;
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
        
        float y=_btnNextFrame.origin.y+[self tableOffsetY];
        
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
            [userCommentCell tableDidScroll:tableShopUser cellRect:rect buttonNextHeight:[self buttonNextHeight]-2];
        }
        
        if(_isKeyboardShowed)
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
            case SHOP_DATA_IDSHOP:
                
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

-(UITableViewCell*) emptyCell
{
    UITableViewCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:@"emptyCell"];
    
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyCell"];
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        [cell l_v_setH:0];
        [cell.contentView l_v_setH:0];
    }
    
    return cell;
}

-(SUKM1Cell*) km1Cell
{
    if(km1Cell)
        return km1Cell;
    
    SUKM1Cell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUKM1Cell reuseIdentifier]];
    cell.delegate=self;
    
    [cell loadWithKM1:_shop.km1];
    
    km1Cell=cell;
    
    return cell;
}

-(SUKM2Cell*) km2Cell
{
    if(km2Cell)
        return km2Cell;
    
    SUKM2Cell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUKM2Cell reuseIdentifier]];
    cell.delegate=self;
    
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
        
        float y=[tableShopUser rectForRowAtIndexPath:SHOP_USER_BUTTON_CONTAIN_INDEX_PATH].origin.y+tableShopUser.l_v_y;
        
        y=MIN(shopNavi.l_v_h-_btnNextFrame.size.height, y);
        
        [btnNext l_v_setY:y];
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
        [userCommentCell reloadData];
        return userCommentCell;
    }
    
    SUUserCommentCell *cell=[tableShopUser dequeueReusableCellWithIdentifier:[SUUserCommentCell reuseIdentifier]];
    
    float height=[SUUserCommentCell heightWithShop:_shop sort:_sortComment];
    float minHeight=[self commentCellMaxHeight];
    
    height=MAX(height,minHeight);
    
    switch (_sortComment) {
        case SORT_SHOP_COMMENT_TIME:
            
            [cell loadWithShop:_shop sort:_sortComment maxHeight:height];
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            [cell loadWithShop:_shop sort:_sortComment maxHeight:height];
            break;
    }
    
    cell.delegate=self;
    
    userCommentCell=cell;
    
    return cell;
}

-(float) commentCellMaxHeight
{
    return _shopUserContentFrame.size.height-_btnNextFrame.size.height-[SUUserCommentCell tableY]+SHOP_USER_ANIMATION_ALIGN_Y;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableShopUser)
    {
        switch (_shop.enumDataMode) {
            case SHOP_DATA_HOME_8:
            case SHOP_DATA_SHOP_LIST:
            case SHOP_DATA_IDSHOP:
                
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
        _sortComment=sort;
        _pageComment=-1;
        
        [detailView showLoading];
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

-(bool)userCommentIsLoadingMore:(SUUserCommentCell *)cell
{
    return _isLoadingMoreComment;
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
    
    if([[FacebookManager shareInstance] permissionTypeForPostToWall]==FACEBOOK_PERMISSION_GRANTED)
    {
        _operationSocialShare=[[ASIOperationSocialShare alloc] initWithContent:comment url:nil image:nil accessToken:[FBSession activeSession].accessTokenData.accessToken socialType:SOCIAL_FACEBOOK];
        _operationSocialShare.delegatePost=self;
        
        [_operationSocialShare startAsynchronous];
    }
}

-(float) buttonNextHeight
{
    if(_shop.km1 || _shop.km2 || _shop.promotionNew)
        return _btnNextFrame.size.height;
    
    return 0;
}

-(float) buttonNextY
{
    if(_shop.km1 || _shop.km2 || _shop.promotionNew)
        return 0;
    
    return _btnNextFrame.origin.y;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableShopUser)
    {
        switch (_shop.enumDataMode) {
            case SHOP_DATA_HOME_8:
            case SHOP_DATA_SHOP_LIST:
            case SHOP_DATA_IDSHOP:
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
                                return 0;
                                
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
                            return 0;
                    }
                        
                    case 3:
                        if(_shop.km1 || _shop.km2 || _shop.promotionNew)
                            return [self buttonNextHeight];
                        else
                        {
                            btnNext.hidden=true;
                            return 0;
                        }
                        
                    case 4:
                        return [SUInfoCell heightWithAddress:_shop.address];
                        
                    case 5:
                        return [SUUserGalleryCell height];
                        
                    case 6:
                    {
                        float height=[SUUserCommentCell heightWithShop:_shop sort:_sortComment] + (_canLoadMoreComment?80:0);
                        float minHeight=[self commentCellMaxHeight];
                        
                        height=MAX(height,minHeight);
                        
                        return height;
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
    shopGalleryController=vc;
    
    [self pushViewController:vc];
}

-(void)galleryFullTouchedBack:(GalleryFullViewController *)controller
{
    if([controller isKindOfClass:[ShopGalleryFullViewController class]])
    {
        _selectedShopGallery=[controller selectedObject];
        [shopGalleryController setSelectedGallery:_selectedShopGallery];
    }
    else if([controller isKindOfClass:[UserGalleryFullViewController class]])
    {
        _selectedUserGallery=[controller selectedObject];
        [shopGalleryController setSelectedGallery:_selectedUserGallery];
    }
}

-(void) pushViewController:(SGViewController*) vc
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        btnClose.alpha=0;
    } completion:^(BOOL finished) {
        btnClose.hidden=true;
    }];
    
    [shopNavi pushViewController:vc onCompleted:^{
        btnBack.hidden=false;
        [btnBack startShowAnimateOnCompleted:nil];
    }];
}

-(void)userGalleryTouchedMakePicture:(SUUserGalleryCell *)cell
{
    ShopCameraViewController *vc=[[ShopCameraViewController alloc] initWithShop:_shop];
    vc.delegate=self;
    
    [self pushViewController:vc];
}

-(void)shopCameraControllerDidUploadPhoto:(ShopCameraViewController *)controller
{
    [self btnBackTouchUpInside:btnBack];
    userGalleryCell=nil;
    [tableShopUser reloadRowsAtIndexPaths:@[SHOP_USER_USER_GALLERY_INDEX_PATH] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)userGalleryTouchedGallery:(SUUserGalleryCell *)cell gallery:(ShopUserGallery *)gallery
{
    ShopGalleryViewController *vc=[[ShopGalleryViewController alloc] initWithShop:_shop withMode:SHOP_GALLERY_VIEW_USER];
    vc.delegate=self;
    
    _selectedUserGallery=gallery;
    
    [vc setSelectedGallery:_selectedUserGallery];
    
    shopGalleryController=vc;
    
    [self pushViewController:vc];
}

-(void)shopGalleryTouchedGallery:(ShopGalleryViewController *)controller gallery:(id)gallery
{
    if([gallery isKindOfClass:[ShopGallery class]])
    {
        _selectedShopGallery=gallery;
        
        ShopGalleryFullViewController *vc=[[ShopGalleryFullViewController alloc] initWithShop:_shop selectedGallery:_selectedShopGallery];
        vc.delegate=self;
        [vc setParentController:self];
    }
    else if([gallery isKindOfClass:[ShopUserGallery class]])
    {
        _selectedUserGallery=gallery;
        
        UserGalleryFullViewController *vc=[[UserGalleryFullViewController alloc] initWithShop:_shop selectedGallery:_selectedUserGallery];
        vc.delegate=self;
        
        [vc setParentController:self];
    }
}

-(void)infoCellTouchedMap:(SUInfoCell *)cell
{
    ShopMapViewController *vc=[[ShopMapViewController alloc] initWithShop:_shop];
    
    [self pushViewController:vc];
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    for(SGViewController *vc in shopNavi.viewControllers)
    {
        if(![vc navigationWillBack])
            return;
    }
    
    [btnBack startHideAnimateOnCompleted:^(UIButton *btn) {
        [shopNavi popViewControllerAnimated:true];
        btnBack.hidden=true;
        
        btnClose.hidden=false;
        btnClose.alpha=0;
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            btnClose.alpha=1;
        }];
    }];
}

-(float) buttonContainHeight
{
    return [self tableView:tableShopUser heightForRowAtIndexPath:SHOP_USER_BUTTON_CONTAIN_INDEX_PATH];
}

-(void)km1TouchedScan:(SUKM1Cell *)km1
{
    [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:[ShopUserViewController screenCode]];
}

-(void)km2TouchedScan:(SUKM2Cell *)cell
{
    [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:[ShopUserViewController screenCode]];
}

@end

@implementation TableShopUser
@synthesize offset;

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(contentOffset.y<-SHOP_USER_ANIMATION_ALIGN_Y)
        contentOffset.y=-SHOP_USER_ANIMATION_ALIGN_Y;
    
    offset=CGPointMake(contentOffset.x-self.contentOffset.x, contentOffset.y-self.contentOffset.y);
    
    [super setContentOffset:contentOffset];
}

@end