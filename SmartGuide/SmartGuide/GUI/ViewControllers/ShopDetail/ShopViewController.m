//
//  ShopDetailViewController.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopViewController.h"
#import "Cells/ShopGalleryTableCell.h"
#import "Cells/ShopInfoTableCell.h"
#import "Cells/ShopDescTableCell.h"
#import "Cells/ShopAddressTableCell.h"
#import "Cells/ShopContactTableCell.h"
#import "Cells/ShopEventTableCell.h"
#import "Cells/ShopUserGalleryTableCell.h"
#import "Cells/ShopRelatedTableCell.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [table registerShopGalleryTableCell];
    [table registerShopInfoTableCell];
    [table registerShopDescTableCell];
    [table registerShopAddressTableCell];
    [table registerShopContactTableCell];
    [table registerShopEventTableCell];
    [table registerShopUserGalleryTableCell];
    [table registerShopRelatedTableCell];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
