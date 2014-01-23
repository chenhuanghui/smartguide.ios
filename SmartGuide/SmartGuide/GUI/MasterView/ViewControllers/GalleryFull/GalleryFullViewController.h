//
//  GalleryFullViewController.h
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "GMGridView.h"

@class GalleryFullViewController,GalleryFullGridCell;

@protocol GalleryFullProtocol <NSObject>

-(id) galleryItemAtIndex:(int) index;

@end

@protocol GalleryFullControllerDelegate <SGViewControllerDelegate>

-(void) galleryFullTouchedBack:(GalleryFullViewController*) controller;

@end

@interface GalleryFullViewController : SGViewController<GMGridViewDataSource,GMGridViewActionDelegate,GalleryFullProtocol,UIScrollViewDelegate>
{
    __weak IBOutlet GMGridView *grid;
    __weak SGViewController *_parentController;
}

-(GalleryFullViewController*) initWithParentController:(SGViewController*) parentControlelr;

-(void) setParentController:(SGViewController*) parentController;
-(id) selectedObject;

@property (nonatomic, weak) id<GalleryFullControllerDelegate> delegate;

@end

@interface GalleryFullGridCell : GMGridViewCell
{
    __weak UIImageView *imageView;
}

-(UIImageView*) imageView;

@end