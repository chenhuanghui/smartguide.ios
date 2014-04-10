//
//  SUUserGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUUserGalleryCell.h"
#import "Utility.h"
#import "ShopUserGalleryCell.h"
#import "SGGridViewLayoutStrategies.h"
#import "GUIManager.h"
#import "GalleryManager.h"
#import "UserUploadGalleryManager.h"

@implementation SUUserGalleryCell
@synthesize delegate;

-(void) makeGalleries
{
    _galleries=[[[GalleryManager shareInstanceWithShop:_shop] shopUserGalleries] mutableCopy];
    _galleriesCount=_galleries.count;
    
    if(_galleries.count>0)
    {
        [_galleries insertObject:@"" atIndex:0];
        [_galleries addObject:@""];
    }
}

-(void)loadWithShop:(Shop *)shop
{
    _shop=shop;
    
    imgvFirsttime.hidden=shop.userGalleriesObjects.count>0 || [shop userGalleriesUpload].count>0;
    
    [self makeGalleries];
    
    grid.delegate=self;
    grid.dataSource=self;
    grid.actionDelegate=self;
    
    [self makeButtonLR];
    
    grid.contentInset=UIEdgeInsetsMake(0, 0, 0, -[ShopUserGalleryCell size].width*2);
    grid.scrollIndicatorInsets=UIEdgeInsetsMake(0, 0, 0, -[ShopUserGalleryCell size].width*2);
}

+(NSString *)reuseIdentifier
{
    return @"SUUserGalleryCell";
}

+(float)height
{
    return 182;
}

-(IBAction) btnMakePictureTouchUpInside:(id)sender
{
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_CAMERA;
            [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
          if(isLogined)
              [self.delegate userGalleryTouchedMakePicture:self];
        }];
        
        return;
    }
    else if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeUserProfileRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_CAMERA;
            [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self.delegate userGalleryTouchedMakePicture:self];
        }];
        
        return;
    }
    
    [self.delegate userGalleryTouchedMakePicture:self];
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return _galleries.count;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [ShopUserGalleryCell size];
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *gCell=[gridView dequeueReusableCell];
    
    if(!gCell)
    {
        gCell=[GMGridViewCell new];
        gCell.contentView=[ShopUserGalleryCell new];
    }

    ShopUserGalleryCell *cell=(ShopUserGalleryCell*) gCell.contentView;
    
    id obj=_galleries[index];
    NSString *url=@"";
    enum SHOP_USER_GALLERY_CELL_STATE state=SHOP_USER_GALLERY_STATE_THUMBNAIL;
    UIImage *image=nil;
    
    if([obj isKindOfClass:[NSString class]])
    {
        state=SHOP_USER_GALLERY_STATE_EMPTY;
        
        if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery && index==[self numberOfItemsInGMGridView:gridView]-1)
        {
            if(![GalleryManager shareInstanceWithShop:_shop].isLoadingMoreUserGallery)
            {
                [[GalleryManager shareInstanceWithShop:_shop] requestUserGallery];
            }
            
            state=SHOP_USER_GALLERY_STATE_LOADING;
        }
    }
    else if([obj isKindOfClass:[ShopUserGallery class]])
    {
        ShopUserGallery *gallery=obj;
        url=gallery.thumbnail;
        state=SHOP_USER_GALLERY_STATE_THUMBNAIL;
    }
    else if([obj isKindOfClass:[UserGalleryUpload class]])
    {
        UserGalleryUpload *upload=obj;
        image=[UIImage imageWithData:upload.image];
    }
    
    if(image)
        [cell loadWithImage:image];
    else
        [cell loadWithURL:url state:state];
    
    return  gCell;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    float x=grid.l_co_x;    
    SGGridViewLayoutHorizontalPagedLTRStrategy *strategy=grid.layoutStrategy;
    int index=[strategy itemPositionFromLocation:CGPointMake(x+([ShopUserGalleryCell size].width*3)/2, [ShopUserGalleryCell size].height/2)];
    if(position==index)
    {
        id obj=_galleries[index];
        
        if([obj isKindOfClass:[ShopUserGallery class]])
            [self.delegate userGalleryTouchedGallery:self gallery:obj];
        else if([obj isKindOfClass:[UserGalleryUpload class]])
            [self.delegate userGalleryTouchedUpload:self gallery:obj];
            
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self makeButtonLR];
}

-(void) makeButtonLR
{
    switch (_galleriesCount) {
        case 0:
        case 1:
            btnLeft.hidden=true;
            btnRight.hidden=true;
            return;
            
        default:
            break;
    }
    
    float x=grid.l_co_x;
    SGGridViewLayoutHorizontalPagedLTRStrategy *strategy=grid.layoutStrategy;
    int index=[strategy itemPositionFromLocation:CGPointMake(x+([ShopUserGalleryCell size].width*3)/2, [ShopUserGalleryCell size].height/2)];
    id obj=nil;
    bool hiddenLeft=true;
    bool hiddenRight=true;
    
    if(index==-1)
    {
        
    }
    else
    {
        if(index-1>0)
        {
            obj=_galleries[index-1];
            
            hiddenLeft=[obj isKindOfClass:[NSString class]];
        }
        if(index+1<_galleries.count)
        {
            obj=_galleries[index+1];
            
            hiddenRight=[obj isKindOfClass:[NSString class]];
        }
    }
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        btnLeft.alpha=hiddenLeft?0:1;
        btnRight.alpha=hiddenRight?0:1;
    }];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    grid.itemSpacing=0;
    grid.centerGrid=false;
    grid.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:SGGridViewLayoutHorizontalPagedLTR];
    grid.minEdgeInsets=UIEdgeInsetsZero;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadImage:) name:NOTIFICATION_GALLERY_FINISED_USER object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_GALLERY_FINISED_USER object:nil];
}

- (IBAction)btnLeftTouchUpInside:(id)sender {
    CGPoint pnt=CGPointMake(grid.l_co_x+[ShopUserGalleryCell size].width*1.5f, [ShopUserGalleryCell size].height/2);
    
    int index=[grid.layoutStrategy itemPositionFromLocation:pnt];
    pnt=[grid.layoutStrategy originForItemAtPosition:index];
    pnt.x-=[ShopUserGalleryCell size].width*2;
    pnt.x=MAX(0,pnt.x);
//    [grid scrollToObjectAtIndex:index-1 atScrollPosition:GMGridViewScrollPositionNone animated:true];
    
    NSLog(@"itemPositionFromLocation %@ %i",NSStringFromCGPoint(pnt),index);
    
    [grid setContentOffset:pnt animated:true];
//    [grid l_co_addX:-[ShopUserGalleryCell size].width animate:true];
}

- (IBAction)btnRightTouchUpInside:(id)sender {
    
    CGPoint pnt=CGPointMake(grid.l_co_x+[ShopUserGalleryCell size].width*1.5f, [ShopUserGalleryCell size].height/2);
    
    int index=[grid.layoutStrategy itemPositionFromLocation:pnt];
    pnt=[grid.layoutStrategy originForItemAtPosition:index];
    pnt.x=MIN(grid.l_cs_w-[ShopUserGalleryCell size].width*2,pnt.x);
    
    NSLog(@"itemPositionFromLocation %@ %i",NSStringFromCGPoint(pnt),index);
    [grid setContentOffset:pnt animated:true];
//    [grid scrollToObjectAtIndex:index atScrollPosition:GMGridViewScrollPositionNone animated:true];
//    [grid l_co_addX:[ShopUserGalleryCell size].width animate:true];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

-(void)reloadImage:(NSNotification*) notification
{
    [self makeGalleries];
    
    [grid reloadData];
    [self scrollViewDidScroll:grid];
}

@end

@implementation UserGalleryGridView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return false;
}

@end