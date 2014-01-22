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

@implementation SUUserGalleryCell
@synthesize delegate;

-(void)loadWithShop:(Shop *)shop
{
    imgvFirsttime.hidden=shop.userGalleriesObjects.count>0;
    
    _galleries=[shop.userGalleriesObjects mutableCopy];
    _galleriesCount=_galleries.count;
    
    if(_galleries.count>0)
    {
        [_galleries insertObject:@"" atIndex:0];
        [_galleries addObject:@""];
    }
    
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
    GMGridViewCell *gCell=[gridView dequeueReusableCellWithIdentifier:[ShopUserGalleryCell reuseIdentifier]];
    
    if(!gCell)
    {
        gCell=[GMGridViewCell new];
        gCell.contentView=[ShopUserGalleryCell new];
    }
    
    ShopUserGalleryCell *cell=(ShopUserGalleryCell*) gCell.contentView;
    
    id obj=_galleries[index];
    NSString *url=@"";
    enum SHOP_USER_GALLERY_CELL_STATE state=SHOP_USER_GALLERY_STATE_THUMBNAIL;
    
    if([obj isKindOfClass:[NSString class]])
    {
        state=SHOP_USER_GALLERY_STATE_EMPTY;
    }
    else
    {
        ShopUserGallery *gallery=obj;
        url=gallery.thumbnail;
        state=SHOP_USER_GALLERY_STATE_THUMBNAIL;
    }
    
    [cell loadWithURL:url state:state];
    
    return  gCell;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    
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
}

@end
