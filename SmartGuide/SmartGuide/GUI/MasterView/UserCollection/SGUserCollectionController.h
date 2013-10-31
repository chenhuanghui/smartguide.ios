//
//  SGUserColllectionController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGUserCollectionViewController.h"
#import "ShopUserViewController.h"
#import "PanDragViewHandle.h"

@interface SGUserCollectionController : UINavigationController<SGUserCollectionDelegate,ShopUserDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,PanDragViewDelegate>
{
    PanDragViewHandle *_panHandle;
    UIPanGestureRecognizer *panGes;
}

@property (nonatomic, strong, readonly) SGUserCollectionViewController *userCollection;

@end
