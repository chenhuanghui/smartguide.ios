//
//  ShopDetailViewController.m
//  SmartGuide
//
//  Created by Khanh Bao Ha Trinh on 7/28/13.
//  Copyright (c) 2013 Khanh Bao Ha Trinh. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"
#import "ShopProduct.h"
#import "ShopInfo.h"
#import "ShopMenu.h"
#import "ShopPicture.h"
#import "ShopComment.h"
#import "ShopLocation.h"
#import "PromotionDetailType1View.h"
#import "PromotionDetailType2View.h"
#import "RootViewController.h"
#import "FrontViewController.h"
#import "SlideQRCodeViewController.h"
#import "AlphaView.h"

@interface ShopDetailViewController ()
{
    ASIOperationPromotionDetail *operationPromotionDetail;
}

@end

@implementation ShopDetailViewController
@synthesize shoplMode,shopLocation,shopComment,shopPicture,shopMenuCategory,shopInfo,promotionDetailType2View,promotionDetailType1View;

- (id)init
{
    self=[super initWithNibName:NIB_PHONE(@"ShopDetailViewController") bundle:nil];
    
    _isShowedShopMenu=false;
    _lastTag=-1;
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"CỬA HÀNG";
    
    lblName.strokeSize=2;
    lblName.strokeColor=[UIColor blackColor];
    lblName.strokePosition=THLabelStrokePositionOutside;
    
    blurCover.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_cover.png"]];
}

-(NSArray*) arrButtons
{
    return @[btnInfo,btnMenu,btnGallery,btnComment,btnMap];
}

-(void) requestShopDetail
{
    if([NSThread isMainThread])
    {
        [self performSelectorInBackground:@selector(requestShopDetail) withObject:nil];
        return;
    }
    
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    int idShop=_shop.idShop.integerValue;
    double lat=[DataManager shareInstance].currentUser.coordinate.latitude;
    double lon=[DataManager shareInstance].currentUser.coordinate.longitude;
    
    _operationShopDetail=[[ASIOperationShopDetail alloc] initWithIDUser:idUser idShop:idShop latitude:lat longtitude:lon];
    _operationShopDetail.delegatePost=self;
    [_operationShopDetail startAsynchronous];
}

-(void) reset
{
    if(_operationShopDetail)
    {
        [_operationShopDetail cancel];
        _operationShopDetail=nil;
    }
    
    if(operationPromotionDetail)
    {
        [operationPromotionDetail cancel];
        operationPromotionDetail=nil;
    }
    
    [shopMenuCategory cancel];
    [shopMenuCategory reset];
    [shopMenuCategory removeFromSuperview];
    
    CGRect rect=shopMenuCategory.frame;
    rect.origin.x=0;
    shopMenuCategory.frame=rect;
    
    [shopPicture cancel];
    [shopPicture reset];
    [shopPicture removeFromSuperview];
    
    rect=shopPicture.frame;
    rect.origin.x=0;
    shopPicture.frame=rect;
    
    [shopComment cancel];
    [shopComment reset];
    [shopComment removeFromSuperview];
    
    rect=shopComment.frame;
    rect.origin.x=0;
    shopComment.frame=rect;
    
    [shopLocation cancel];
    [shopLocation reset];
    [shopLocation removeFromSuperview];
    
    rect=shopLocation.frame;
    rect.origin.x=0;
    shopLocation.frame=rect;
    
    rect=shopInfo.frame;
    rect.origin.x=0;
    shopInfo.frame=rect;
    
    [[self currentPromotionDetailView] reset];
    [promotionDetailType1View removeFromSuperview];
    [promotionDetailType2View removeFromSuperview];
    
    while (viewContaint.subviews.count>0) {
        [[viewContaint.subviews objectAtIndex:0] removeFromSuperview];
    }
}

-(void) showShopMenu:(bool) animated
{
    if(_isAnimationMenu)
        return;
    
    _isShowedShopMenu=true;
    
    _isAnimationMenu=false;
    if(animated)
    {
        _isAnimationMenu=true;
        
        [UIView animateWithDuration:DURATION_SHOW_MENU_SHOP_DETAIL animations:^{
            CGRect rect=btnPromotion.frame;
            rect.origin=CGPointMake(0, 119);
            rect.size=CGSizeMake(84, 35);
            btnPromotion.frame=rect;
            
            rect=buttonsContaint.frame;
            rect.origin.x=0;
            buttonsContaint.frame=rect;
            
            btnShop.alpha=0;
            
            rect=pick.frame;
            rect.origin=CGPointMake(92, 145);
            pick.frame=rect;
            
            rect=imgvSwitch.frame;
            rect.origin=CGPointMake(87, 122);
            imgvSwitch.frame=rect;
            imgvSwitch.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
            
            btnPromotion.titleLabel.font=[UIFont boldSystemFontOfSize:9];
            btnShop.titleLabel.font=[UIFont boldSystemFontOfSize:10];
        } completion:^(BOOL finished) {
            _isAnimationMenu=false;
            btnShop.hidden=true;
        }];
    }
    else
    {
        CGRect rect=btnPromotion.frame;
        rect.origin=CGPointMake(0, 122);
        rect.size=CGSizeMake(84, 35);
        btnPromotion.frame=rect;
        
        rect=buttonsContaint.frame;
        rect.origin.x=0;
        buttonsContaint.frame=rect;
        
        btnShop.alpha=0;
        btnShop.hidden=true;
        
        rect=pick.frame;
        rect.origin=CGPointMake(92, 145);
        pick.frame=rect;
        
        rect=imgvSwitch.frame;
        rect.origin=CGPointMake(87, 119);
        imgvSwitch.frame=rect;
        imgvSwitch.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
        
        btnPromotion.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        btnShop.titleLabel.font=[UIFont boldSystemFontOfSize:10];
    }
}

-(void) hideShopMenu:(bool) animated
{
    if(_isAnimationMenu)
        return;
    
    _isShowedShopMenu=false;
    
    _isAnimationMenu=false;
    if(animated)
    {
        _isAnimationMenu=true;
        btnShop.hidden=false;
        
        [UIView animateWithDuration:DURATION_SHOW_MENU_SHOP_DETAIL animations:^{
            CGRect rect=btnPromotion.frame;
            rect=CGRectMake(0, 119, 212, 35);
            btnPromotion.frame=rect;
            
            rect=imgvSwitch.frame;
            rect.origin=CGPointMake(210, 122);
            imgvSwitch.frame=rect;
            imgvSwitch.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
            
            rect=buttonsContaint.frame;
            rect.origin.x=rect.size.width-84;
            buttonsContaint.frame=rect;
            
            btnShop.alpha=1;
            
            rect=pick.frame;
            rect.origin=CGPointMake(92, 145);
            pick.frame=rect;
            
            btnPromotion.titleLabel.font=[UIFont boldSystemFontOfSize:10];
            btnShop.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        } completion:^(BOOL finished) {
            _isAnimationMenu=false;
        }];
    }
    else
    {
        CGRect rect=btnPromotion.frame;
        rect=CGRectMake(0, 119, 212, 35);
        btnPromotion.frame=rect;
        
        rect=imgvSwitch.frame;
        rect.origin=CGPointMake(210, 122);
        imgvSwitch.frame=rect;
        imgvSwitch.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
        
        rect=buttonsContaint.frame;
        rect.origin.x=rect.size.width-84;
        buttonsContaint.frame=rect;
        
        rect=pick.frame;
        rect.origin=CGPointMake(92, 145);
        pick.frame=rect;
        
        btnShop.hidden=false;
        btnShop.alpha=1;
        
        btnPromotion.titleLabel.font=[UIFont boldSystemFontOfSize:10];
        btnShop.titleLabel.font=[UIFont boldSystemFontOfSize:9];
    }
}

-(void) alignButtonLikeDislike
{
    CGRect rect=CGRectMake(92, 89, 52, 25);
    
    int length=[btnDislike titleForState:UIControlStateNormal].length;
    rect.origin.x-=length==0?0:length+5;
    
    btnLike.frame=rect;
    
    rect=btnDislike.frame;
    rect.origin.x=btnLike.frame.origin.x+btnLike.frame.size.width+6;
    btnDislike.frame=rect;
    
    //    [self performSelector:@selector(testAlignButton) withObject:nil afterDelay:0.05f];
}

-(void) testAlignButton
{
    [btnDislike setTitle:[NSString stringWithFormat:@"%i",[btnDislike titleForState:UIControlStateNormal].integerValue+10] forState:UIControlStateNormal];
    
    [self alignButtonLikeDislike];
}

-(void)loadWithIDShop:(int)idShop
{
    if(_shop.idShop.integerValue==idShop)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOPDETAIL_LOAD_FINISHED object:nil];
        return;
    }
    
    if(_operationShopDetail)
    {
        [_operationShopDetail cancel];
        _operationShopDetail=nil;
    }
    
    _isSelfLoaded=true;
    
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    double lat=[DataManager shareInstance].currentUser.location.latitude;
    double lon=[DataManager shareInstance].currentUser.location.longitude;
    _operationShopDetail=[[ASIOperationShopDetail alloc] initWithIDUser:idUser idShop:idShop latitude:lat longtitude:lon];
    _operationShopDetail.delegatePost=self;
    [_operationShopDetail startAsynchronous];
}

-(void) setupShop:(Shop*) shop completed:(void(^)()) onCompleted
{
    [self hideShopMenu:false];
    
    [self.promotionDetailType1View removeFromSuperview];
    [self.promotionDetailType2View removeFromSuperview];
    
    if(!_likeDislikeFormat)
    {
        _likeDislikeFormat=[[NSNumberFormatter alloc] init];
        _likeDislikeFormat.numberStyle=NSNumberFormatterNoStyle;
        _likeDislikeFormat.generatesDecimalNumbers=false;
        _likeDislikeFormat.groupingSeparator=@".";
    }
    
    _lastTag=-1;
    _shop=shop;
    
    [self.view removeAlphaView];
    [self.navigationController.view removeAlphaView];
    
    imgvLogo.image=nil;
    imgvCover.image=nil;
    
    btnPromotion.enabled=true;
    
    while (viewContaint.subviews.count>0) {
        [[viewContaint.subviews objectAtIndex:0] removeFromSuperview];
    }
    
    if(_shop)
    {
        btnLike.userInteractionEnabled=true;
        btnDislike.userInteractionEnabled=true;
        [btnLike setTitle:[_likeDislikeFormat stringFromNumber:shop.like] forState:UIControlStateNormal];
        [btnDislike setTitle:[_likeDislikeFormat stringFromNumber:shop.dislike] forState:UIControlStateNormal];
        btnLike.selected=shop.like_status.integerValue==1;
        btnDislike.selected=shop.like_status.integerValue==2;
        
        [self alignButtonLikeDislike];
        
        [imgvLogo setSmartGuideImageWithURL:[NSURL URLWithString:_shop.logo] placeHolderImage:UIIMAGE_LOADING_SHOP_LOGO success:nil failure:nil];
        
        //      cover shop được set khi api shop detail được load
        //      [imgvCover setImageWithURL:[NSURL URLWithString:_shop.cover]];
        
        //        self.title=_shop.name;
        lblName.text=[_shop.name uppercaseString];
        if(_shop.promotionDetail)
        {
            if(_shop.promotionDetail.promotionType.integerValue==1)
            {
                [promotionDetailType1View setShop:_shop];
                [promotionDetailType1View setNeedAnimationScore];
                [viewContaint addSubview:promotionDetailType1View];
                
                if(_shop.promotionDetail.sgp.integerValue==0)
                    [btnShop sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [promotionDetailType2View setShop:_shop];
                
                [viewContaint addSubview:promotionDetailType2View];
                
                [btnShop sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
        else
        {
            btnPromotion.enabled=false;
            [btnShop sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
        onCompleted();
        onCompleted=nil;
    }
    else
    {
        onCompleted();
        onCompleted=nil;
    }
}

-(void)setShop:(Shop *)shop
{
    _isSelfLoaded=false;
    [self setupShop:shop completed:^{
        if(shop)
        {
            [self requestShopDetail];
        }
        else
            [self reset];
    }];
}

- (void)viewDidUnload {
    imgvCover = nil;
    imgvLogo = nil;
    viewContaint = nil;
    rootView = nil;
    bgMenu = nil;
    pick = nil;
    imgvSwitch = nil;
    btnLike = nil;
    btnDislike = nil;
    lblName = nil;
    btnPromotion = nil;
    btnInfo = nil;
    btnMenu = nil;
    btnGallery = nil;
    btnComment = nil;
    btnMap = nil;
    btnShop = nil;
    blurCover = nil;
    
    imgvBtnHover = nil;
    [super viewDidUnload];
}

-(void)shopMenuShow:(enum SHOP_MENU_TYPE)type direction:(enum SHOP_MENU_DIRECTION)direction
{
    switch (type) {
        case MENU_INFO:
            [shopInfo setShop:_shop];
            [self animationView:shopInfo direction:direction onCompleted:nil];
            break;
            
        case MENU_MENU:
            [shopMenuCategory setShop:_shop];
            [self animationView:shopMenuCategory direction:direction onCompleted:nil];
            break;
            
        case MENU_CAMERA:
            [self showCamera];
            break;
            
        case MENU_PICTURE:
            [self animationView:shopPicture direction:direction onCompleted:nil];
            break;
            
        case MENU_COMMENT:
        {
            [self animationView:shopComment direction:direction onCompleted:nil];
        }
            break;
            
        case MENU_MAP:
        {
            [self animationView:shopLocation direction:direction onCompleted:nil];
        }
            break;
            
        default:
            break;
    }
}

-(void) showCamera
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.modalPresentationStyle=UIModalPresentationCurrentContext;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    else
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate=self;
    
    [self.navigationController presentModalViewController:imagePicker animated:true];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img=[info valueForKey:UIImagePickerControllerOriginalImage];
    
    ShopUserPose *userPose=[[ShopUserPose alloc] init];
    userPose.delegate=self;
    
    rootView=[[RootViewController shareInstance] giveARootView];
    rootView.backgroundColor=[UIColor whiteColor];
    [rootView addSubview:userPose];
    
    [self dismissModalViewControllerAnimated:true];
    
    [userPose setImage:img shop:_shop];
}

-(void)shopUserPostCancelled:(ShopUserPose *)userPose
{
    [self removeUserPose:userPose];
}

-(void)shopUserPostFinished:(ShopUserPose *)userPose userGallery:(ShopUserGallery *)userGallery
{
    if(userGallery)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_POST_PICTURE object:userGallery];
        
        [btnGallery sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        [self removeUserPose:userPose];
    }
    else
    {
        [self removeUserPose:userPose];
    }
}

-(void) removeUserPose:(ShopUserPose*) userPose
{
    userPose.delegate=nil;
    [userPose removeFromSuperview];
    userPose=nil;
    [[RootViewController shareInstance] removeRootView:rootView];
    rootView=nil;
}

-(void) animationView:(UIView*) newView direction:(enum SHOP_MENU_DIRECTION) direction onCompleted:(void(^)()) onCompleted
{
    if(viewContaint.subviews.count==0)
    {
        [viewContaint addSubview:newView];
        return;
    }
    
    if([viewContaint.subviews objectAtIndex:0]==newView)
        return;
    UIView *currentView=[viewContaint.subviews objectAtIndex:0];
    [viewContaint addSubview:newView];
    
    switch (direction) {
        case MENU_FIRST:
            newView.alpha=0;
            break;
            
        case MENU_LEFT_TO_RIGHT:
        {
            CGRect rect=newView.frame;
            rect.origin.x=rect.size.width;
            newView.frame=rect;
        }
            break;
            
        case MENU_RIGHT_TO_LEFT:
        {
            CGRect rect=newView.frame;
            rect.origin.x=-rect.size.width;
            newView.frame=rect;
        }
            break;
    }
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        
        CGRect rect=CGRectZero;
        
        newView.alpha=1;
        currentView.alpha=0;
        
        switch (direction) {
            case MENU_FIRST:
                rect=newView.frame;
                rect.origin.x=0;
                newView.frame=rect;
                break;
                
            case MENU_LEFT_TO_RIGHT:
                rect=currentView.frame;
                rect.origin.x=-rect.size.width;
                currentView.frame=rect;
                
                rect=newView.frame;
                rect.origin.x=0;
                newView.frame=rect;
                break;
                
            case MENU_RIGHT_TO_LEFT:
                rect=currentView.frame;
                rect.origin.x=rect.size.width;
                currentView.frame=rect;
                
                rect=newView.frame;
                rect.origin.x=0;
                newView.frame=rect;
                break;
        }
    } completion:^(BOOL finished) {
        [currentView removeFromSuperview];
        currentView.alpha=1;
        
        if(onCompleted)
            onCompleted();
    }];
}

-(void)shopMenuHideDetail
{
    _lastTag=-1;
    if(_shop.promotionDetail.promotionType.integerValue==1)
    {
        [self animationView:promotionDetailType1View direction:MENU_FIRST onCompleted:^{
        }];
    }
    else
        [self animationView:promotionDetailType2View direction:MENU_FIRST onCompleted:nil];
}

-(void) shopMenuShowDetail
{
    [shopInfo setShop:_shop];
    _lastTag=shopInfo.tag;
    [self moveHover:btnInfo];
    [self animationView:shopInfo direction:MENU_FIRST onCompleted:nil];
}

-(void) shopMenuCategoryProcessFirstData:(NSMutableArray*) array
{
    [self.shopMenuCategory processFirstDataBackground:array];
}

-(void) shopPictureProcessFirstData:(NSMutableArray*) array
{
    [self.shopPicture processFirstDataBackground:array];
}

-(void) shopCommentProcessFirstData:(NSMutableArray*) array
{
    [self.shopComment processFirstDataBackground:array];
}

-(void) shopLocationProcessFirstData:(NSMutableArray*) array
{
    [self.shopLocation processFirstDataBackground:array];
}

-(void) startProcessShopDetailWithProducts:(NSMutableArray*) products shopGalleries:(NSMutableArray*) shopGalleries userGalleries:(NSMutableArray*) userGalleries comments:(NSMutableArray*) comments
{
    [shopMenuCategory setShop:_shop];
    [shopPicture setShop:_shop];
    [shopComment setShop:_shop];
    [shopLocation setShop:_shop];
    
    shopMenuCategory.isProcessedData=false;
    shopPicture.isProcessedData=false;
    shopComment.isProcessedData=false;
    shopLocation.isProcessedData=false;
    
    [self performSelectorInBackground:@selector(shopMenuCategoryProcessFirstData:) withObject:[products copy]];
    [self performSelectorInBackground:@selector(shopPictureProcessFirstData:) withObject:@[[shopGalleries copy],[userGalleries copy]]];
    [self performSelectorInBackground:@selector(shopCommentProcessFirstData:) withObject:[comments copy]];
    [self performSelectorInBackground:@selector(shopLocationProcessFirstData:) withObject:[NSArray array]];
    
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopDetail class]])
    {
        ASIOperationShopDetail *ope=(ASIOperationShopDetail*) operation;
        
        [imgvCover setSmartGuideImageWithURL:[NSURL URLWithString:_shop.cover] placeHolderImage:UIIMAGE_LOADING_SHOP_COVER success:nil failure:nil];
        
        _shop=ope.shop;
        
        if(_isSelfLoaded)
            [self setShop:ope.shop];
        
        [self startProcessShopDetailWithProducts:ope.products shopGalleries:ope.shopGalleries userGalleries:ope.userGalleries comments:ope.comments];
        
        _operationShopDetail=nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOPDETAIL_LOAD_FINISHED object:nil];
    }
    else if([operation isKindOfClass:[ASIOperationPromotionDetail class]])
    {
        operationPromotionDetail=nil;
        [[self currentPromotionDetailView] removeLoading];
        
        _shop=[Shop shopWithIDShop:_shop.idShop.integerValue];
        
        [[self currentPromotionDetailView] reloadWithShop:_shop];
    }
    else if([operation isKindOfClass:[ASIOperationLikeDislikeShop class]])
    {
        ASIOperationLikeDislikeShop *ope=(ASIOperationLikeDislikeShop*)operation;
        
        btnLike.userInteractionEnabled=true;
        btnDislike.userInteractionEnabled=true;
        
        [btnLike setTitle:[_likeDislikeFormat stringFromNumber:@(ope.like)] forState:UIControlStateNormal];
        [btnDislike setTitle:[_likeDislikeFormat stringFromNumber:@(ope.dislike)] forState:UIControlStateNormal];
        
        _shop.like=@(ope.like);
        _shop.dislike=@(ope.dislike);
        _shop.like_status=@(ope.likeStatus);
        
        btnLike.selected=_shop.like_status.integerValue==1;
        btnDislike.selected=_shop.like_status.integerValue==2;
        
        [self alignButtonLikeDislike];
        
        _operationLikeDislike=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationPromotionDetail class]])
    {
        [[self currentPromotionDetailView] removeLoading];
        
        operationPromotionDetail=nil;
    }
    else if([operation isKindOfClass:[ASIOperationLikeDislikeShop class]])
    {
        btnLike.userInteractionEnabled=true;
        btnDislike.userInteractionEnabled=true;
        
        _operationLikeDislike=nil;
    }
}

-(bool)allowDragPreviousView:(UIPanGestureRecognizer *)pan
{
    CGPoint pnt=[pan translationInView:pan.view];
    
    if(pnt.x<0)
        return false;
    
    if(viewContaint.subviews.count>0)
    {
        if([[viewContaint.subviews objectAtIndex:0] isKindOfClass:[ShopPicture class]])
        {
            UIView *v=[viewContaint.subviews objectAtIndex:0];
            CGPoint location=[pan locationInView:v];
            
            if(CGRectContainsPoint(v.frame, location))
                return false;
        }
        else if([[viewContaint.subviews objectAtIndex:0] isKindOfClass:[ShopLocation class]])
        {
            return true;
            
            CGPoint location=[pan locationInView:shopLocation.mapContaint];
            CGRect rect=shopLocation.mapContaint.frame;
            rect.origin=CGPointZero;
            
            if(CGRectContainsPoint(rect, location))
                return false;
        }
        else if([[viewContaint.subviews objectAtIndex:0] isKindOfClass:[ShopComment class]])
        {
            if([shopComment isShowedBigComment])
                return false;
            
            CGPoint trans = [pan translationInView:pan.view];
            
            return fabsf(trans.x)>fabsf(trans.y);
        }
        else if([[viewContaint.subviews objectAtIndex:0] isKindOfClass:[ShopMenu class]])
        {
            CGPoint trans = [pan translationInView:pan.view];
            
            return fabsf(trans.x)>fabsf(trans.y);
        }
        else if([[viewContaint.subviews objectAtIndex:0] isKindOfClass:[ShopInfo class]])
        {
            CGPoint trans = [pan translationInView:pan.view];
            
            return fabsf(trans.x)>fabsf(trans.y);
        }
    }
    
    return [super allowDragPreviousView:pan];
}

-(NSArray *)rightNavigationItems
{
    if(self.shoplMode==SHOPDETAIL_FROM_MAP)
        return @[@(ITEM_FILTER),@(ITEM_COLLECTION),@(ITEM_MAP)];
    else
        return @[@(ITEM_FILTER),@(ITEM_COLLECTION),@(ITEM_LIST)];
}

-(void)willPopViewController
{
    [super willPopViewController];
}

-(void)loadView
{
    [super loadView];
    
    [btnDislike setTrickFont:btnDislike.titleLabel.font];
    
    rootView.layer.cornerRadius=8;
    rootView.layer.masksToBounds=true;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _isLoadedViews=false;
        
        self.shopInfo=[[ShopInfo alloc] initWithShop:nil];
        self.shopMenuCategory=[[ShopMenu alloc] initWithShop:nil];
        self.shopPicture=[[ShopPicture alloc] initWithShop:nil];
        self.shopComment=[[ShopComment alloc] initWithShop:nil];
        self.shopLocation=[[ShopLocation alloc] initWithShop:nil];
        self.promotionDetailType1View=[[PromotionDetailType1View alloc] initWithShop:nil];
        self.promotionDetailType2View=[[PromotionDetailType2View alloc] initWithShop:nil];
        
        self.shopMenuCategory.handler=self;
        self.shopPicture.handler=self;
        self.shopComment.handler=self;
        self.shopLocation.handler=self;
        self.promotionDetailType1View.handler=self;
        self.promotionDetailType2View.handler=self;
        
        _isLoadedViews=true;
    });
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self animationScore];
}

-(void) animationScore
{
    if(_shop && _shop.promotionDetail && _shop.promotionDetail.promotionType.integerValue==1)
    {
        [self.promotionDetailType1View animationScore];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    while (!_isLoadedViews) {
        sleep(0.1f);
    }
    
    if(![Flags isShowedTutorialSlideShopDetail])
    {
        if(!imgvTutorial)
        {
            imgvTutorial=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Truot.png"]];
            imgvTutorial.frame=CGRectMake(0, self.view.frame.size.height/2-56/2, 62, 56);
            
            imgvTutorial.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-25));
            
            imgvTutorialText=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Truot_text.png"]];
            imgvTutorialText.frame=CGRectMake(0, imgvTutorial.frame.origin.y+imgvTutorial.frame.size.height-10, 62, 32);
            
            [self.view addSubview:imgvTutorial];
            [self.view addSubview:imgvTutorialText];
            
            [self startAnimationTutorial];
        }
    }
    else
    {
        if(imgvTutorial)
        {
            [imgvTutorial removeFromSuperview];
            imgvTutorial=nil;
            
            [imgvTutorialText removeFromSuperview];
            imgvTutorialText=nil;
        }
    }
}

-(void) startAnimationTutorial
{
    [UIView animateWithDuration:0.5f animations:^{
        imgvTutorial.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
        //        imgvTutorial.center=CGPointMake(imgvTutorial.center.x, imgvTutorial.center.y-10)
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f animations:^{
            imgvTutorial.transform=CGAffineTransformMakeRotation(-25);
        } completion:^(BOOL finished) {
            [self startAnimationTutorial];
        }];
    }];
}

-(void) reloadPromotionDetail
{
    if([NSThread isMainThread])
    {
        [self performSelectorInBackground:@selector(reloadPromotionDetail) withObject:nil];
        return;
    }
    //user->shopdetail->qrcode->shopdetail->cancel previous operation
    if(operationPromotionDetail)
    {
        [operationPromotionDetail cancel];
        operationPromotionDetail=nil;
    }
    
    operationPromotionDetail=[[ASIOperationPromotionDetail alloc] initWithIDShop:_shop.idShop.integerValue idUser:[DataManager shareInstance].currentUser.idUser.integerValue];
    operationPromotionDetail.delegatePost=self;
    
    [operationPromotionDetail startAsynchronous];
}

-(id<PromotionDetailHandle>) currentPromotionDetailView
{
    if(_shop.promotionDetail.promotionType.integerValue==1)
        return promotionDetailType1View;
    else
        return promotionDetailType2View;
}

-(bool)allowBannerAds
{
    return false;
}

-(NSArray *)disableRightNavigationItems
{
    if([RootViewController shareInstance].isShowedShopDetailFromMap)
    {
        return @[@(ITEM_LIST),@(ITEM_MAP),@(ITEM_FILTER),@(ITEM_COLLECTION)];
    }
    
    return @[@(ITEM_LIST),@(ITEM_MAP),@(ITEM_FILTER)];
}

-(void) movePickToPoint:(CGPoint) pnt
{
    [UIView animateWithDuration:0.2f animations:^{
        pick.center=CGPointMake(pnt.x, pick.center.y);
    } completion:^(BOOL finished) {
    }];
}

-(void) setButtonState:(UIButton*) btn
{
    btn.highlighted=true;
}

-(void) moveHover:(UIButton*) btn
{
    for(UIButton *button in [self arrButtons])
    {
        button.highlighted=false;
    }
    
    if(![[self arrButtons] containsObject:btn])
    {
    }
    
    [self performSelector:@selector(setButtonState:) withObject:btn afterDelay:0];
    
    CGRect rect=imgvBtnHover.frame;
    if(btn==btnInfo)
        rect.origin.x=90;
    else if(btn==btnMenu)
        rect.origin.x=132;
    else if(btn==btnGallery)
        rect.origin.x=172;
    else if(btn==btnComment)
        rect.origin.x=213;
    else if(btn==btnMap)
        rect.origin.x=252;
    
    [UIView animateWithDuration:0.2f animations:^{
        imgvBtnHover.frame=rect;
    }];
}

-(void) btnClick:(UIButton*) btn;
{
    [self movePickToPoint:btn.center];
    [self moveHover:btn];
    
    enum SHOP_MENU_DIRECTION direction=MENU_FIRST;
    
    if(_lastTag!=-1)
    {
        if(_lastTag>btn.tag)
            direction=MENU_RIGHT_TO_LEFT;
        else
            direction=MENU_LEFT_TO_RIGHT;
    }
    
    _lastTag=btn.tag;
    
    switch (btn.tag) {
        case 1:
            [self shopMenuShow:MENU_INFO direction:direction];
            break;
            
        case 2:
            [self shopMenuShow:MENU_MENU direction:direction];
            break;
            
        case 3:
            [self shopMenuShow:MENU_CAMERA direction:direction];
            break;
            
        case 4:
            [self shopMenuShow:MENU_PICTURE direction:direction];
            break;
            
        case 5:
            [self shopMenuShow:MENU_COMMENT direction:direction];
            break;
            
        case 6:
            [self shopMenuShow:MENU_MAP direction:direction];
            break;
            
        default:
            break;
    }
}

- (IBAction)btnPromotionTouchUpInside:(id)sender {
    if(_isShowedShopMenu)
    {
        [self hideShopMenu:true];
        [self shopMenuHideDetail];
    }
}

- (IBAction)btnInfoTouchUpInside:(id)sender {
    [self btnClick:(UIButton*)sender];
}
- (IBAction)btnMenuTouchUpInside:(id)sender {
    [self btnClick:(UIButton*)sender];
}
- (IBAction)btnCameraTouchUpInside:(id)sender {
    [self showCamera];
}
- (IBAction)btnGalleryTouchUpInside:(id)sender {
    [self btnClick:(UIButton*)sender];
}
- (IBAction)btnCommentTouchUpInside:(id)sender {
    [self btnClick:(UIButton*)sender];
}
- (IBAction)btnMapTouchUpInside:(id)sender {
    [self btnClick:(UIButton*)sender];
}

- (IBAction)btnShopTouchUpInside:(id)sender {
    if(!_isShowedShopMenu)
    {
        [self showShopMenu:true];
        [self shopMenuShowDetail];
    }
}

- (IBAction)btnLikeTouchUpInside:(id)sender {
    if(_shop.like_status.integerValue==1)
    {
//        [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn đã like shop" onOK:nil];
        return;
    }
    
    btnDislike.selected=false;
    btnLike.selected=true;
    
    [self likeDislikeShop:LIKE];
}
- (IBAction)btnDislikeTouchUpInside:(id)sender {
    if(_shop.like_status.integerValue==2)
    {
//        [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn đã dislike shop" onOK:nil];
        return;
    }
    
    btnDislike.selected=true;
    btnLike.selected=false;
    
    [self likeDislikeShop:DISLIKE];
}

-(void) likeDislikeShop:(enum LIKE_STATUS) likeDislike
{
    if(_operationLikeDislike)
    {
        [_operationLikeDislike cancel];
        _operationLikeDislike=nil;
    }
    
    btnLike.userInteractionEnabled=false;
    btnDislike.userInteractionEnabled=false;
    
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    
    _operationLikeDislike=[[ASIOperationLikeDislikeShop alloc] initWithIDShop:_shop.idShop.integerValue userID:idUser type:likeDislike status:_shop.like_status.integerValue];
    _operationLikeDislike.delegatePost=self;
    
    [_operationLikeDislike startAsynchronous];
}

@end

@implementation ShopDetailView



@end