//
//  ShopDetailInfoViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoViewController.h"
#import "ShopDetailInfoToolCell.h"
#import "ShopDetailInfoDetailCell.h"
#import "ShopDetailInfoImageCell.h"

@interface ShopDetailInfoViewController ()

@end

@implementation ShopDetailInfoViewController

- (id)init
{
    self = [super initWithNibName:@"ShopDetailInfoViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) storeRect
{
    _introFrame=introView.frame;
    _toolFrame=toolView.frame;
    _detailFrame=detailView.frame;
    _imageFrame=imageView.frame;
    
    _contentFrame=lblContent.frame;
    _tableToolFrame=tableTool.frame;
    _tableDetailFrame=tableDetail.frame;
    _tableImageFrame=tableImage.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self storeRect];
    
    [tableTool registerNib:[UINib nibWithNibName:[ShopDetailInfoToolCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoToolCell reuseIdentifier]];
    [tableDetail registerNib:[UINib nibWithNibName:[ShopDetailInfoDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoDetailCell reuseIdentifier]];
    [tableImage registerNib:[UINib nibWithNibName:[ShopDetailInfoImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoImageCell reuseIdentifier]];
    
    [self alignIntro];
    
    tableTool.dataSource=self;
    tableTool.delegate=self;
    [tableTool reloadData];
    
    [self alignTool];
    
    tableDetail.dataSource=self;
    tableDetail.delegate=self;
    [tableDetail reloadData];
    
    [self alignDetail];
    
    tableImage.dataSource=self;
    tableImage.delegate=self;
    [tableImage reloadData];
    
    [self alignImage];
}

-(void) alignIntro
{
    
}

-(void) alignTool
{
    
}

-(void) alignDetail
{
    
}

-(void) alignImage
{
    
}

-(void) alignView
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableTool)
    {
        ShopDetailInfoToolCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopDetailInfoToolCell reuseIdentifier]];
        
        [cell loadWithContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." withState:rand()%2==0];
        
        return cell;
    }
    else if(tableView==tableDetail)
    {
        ShopDetailInfoDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopDetailInfoDetailCell reuseIdentifier]];
        
        [cell loadWithName:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." withContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
        
        return cell;
    }
    else if(tableView==tableImage)
    {
        ShopDetailInfoImageCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopDetailInfoImageCell reuseIdentifier]];
        
        [cell loadWithImage:[UIImage imageNamed:@"ava.png"] withTitle:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." withContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableTool)
    {
        return [ShopDetailInfoToolCell heightWithContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
    }
    else if(tableView==tableDetail)
    {
        return [ShopDetailInfoDetailCell heightWithContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
    }
    else if(tableView==tableImage)
    {
        return [ShopDetailInfoImageCell heightWithContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
    }
    
    return 0;
}

@end
