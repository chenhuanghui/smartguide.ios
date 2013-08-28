//
//  FilterViewController.m
//  SmartGuide
//
//  Created by XXX on 7/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "FilterViewController.h"
#import "Utility.h"
#import "Filter.h"
#import "DataManager.h"
#import "Constant.h"
#import "RootViewController.h"
#import "FrontViewController.h"
#import "CatalogueListViewController.h"

@interface FilterViewController ()

@property (nonatomic, readonly) UITapGestureRecognizer *tapGes;

@end

@implementation FilterViewController
@synthesize tapGes,delegate;

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
    
    self.title=@"Filter";
    
    tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGes.delegate=self;
    [self.view addGestureRecognizer:tapGes];
}

-(void) setHighlight:(bool) highlighted filter:(UIView*) filter
{
    UIColor *colorName=[UIColor whiteColor];
    UIColor *colorSubname=[UIColor whiteColor];
    if(highlighted)
    {
        colorName=[UIColor whiteColor];
        colorSubname=[UIColor color255WithRed:162 green:173 blue:180 alpha:255];
        [self iconWithFilter:filter].highlighted=false;
        [self pinWithFilter:filter].highlighted=false;
    }
    else
    {
        colorName=[UIColor color255WithRed:117 green:117 blue:117 alpha:255];
        colorSubname=colorName;
        [self iconWithFilter:filter].highlighted=true;
        [self pinWithFilter:filter].highlighted=true;
    }
    
    filter.tag=highlighted;
    //    [self iconWithFilter:filter].highlighted=highlighted;
    //    [self pinWithFilter:filter].highlighted=highlighted;
    [self nameWithFilter:filter].textColor=colorName;
    [self subnameWithFilter:filter].textColor=colorSubname;
}

-(bool) isHighlighted:(UIView*) filter
{
    return filter.tag;
}

-(UIButton*) iconWithFilter:(UIView*) filter
{
    for (id btn in filter.subviews) {
        if([btn isKindOfClass:[FilterButton class]])
            return btn;
    }
    
    return nil;
}

-(UIButton*) pinWithFilter:(UIView*) filter
{
    for(UIButton *btn in filter.subviews)
        if(btn.tag==2)
            return btn;
    
    return nil;
}

-(UILabel*) nameWithFilter:(UIView*) filter
{
    return (UILabel*)[filter viewWithTag:3];
}

-(UILabel*) subnameWithFilter:(UIView*) filter
{
    return (UILabel*)[filter viewWithTag:4];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==tapGes)
    {
        CGPoint pnt=[tapGes locationInView:self.view];
        
        for(UIView *filter in [self filters])
        {
            if(CGRectContainsPoint(filter.frame, pnt))
                return true;
        }
        
        return false;
    }
    
    return true;
}

-(NSArray*) filters
{
    return @[food,drink,health,entertaiment,fashion,travel,production,education];
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    switch (tap.state) {
        case UIGestureRecognizerStateEnded:
        {
            CGPoint pnt=[tap locationInView:self.view];
            
            UIView *filter=nil;
            for(filter in [self filters])
            {
                if(CGRectContainsPoint(filter.frame, pnt))
                {
                    [self setHighlight:![self isHighlighted:filter] filter:filter];
                    break;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadFilter];
}

-(void)loadFilter
{
    Filter *filter=[[DataManager shareInstance] currentUser].filter;
    
    if(filter)
    {
        [self setHighlight:filter.food.boolValue filter:food];
        [self setHighlight:filter.drink.boolValue filter:drink];
        [self setHighlight:filter.health.boolValue filter:health];
        [self setHighlight:filter.entertaiment.boolValue filter:entertaiment];
        [self setHighlight:filter.fashion.boolValue filter:fashion];
        [self setHighlight:filter.travel.boolValue filter:travel];
        [self setHighlight:filter.production.boolValue filter:production];
        [self setHighlight:filter.education.boolValue filter:education];
        
        btnAward.selected=filter.mostGetReward.boolValue;
        btnPoint.selected=filter.mostGetPoint.boolValue;
        btnLike.selected=filter.mostLike.boolValue;
        btnView.selected=filter.mostView.boolValue;
        btnDistance.selected=filter.distance.boolValue;
    }
    else
    {
        [self btnCheckNonTouchUpInside:nil];
        
        btnAward.selected=false;
        btnPoint.selected=false;
        btnLike.selected=false;
        btnView.selected=false;
        btnDistance.selected=true;
    }
}

+(CGSize)size
{
    return CGSizeMake(320, 422);
}

-(NSArray*) radioButtons
{
    return @[btnAward,btnDistance,btnLike,btnPoint,btnView];
}

-(void) setChecked:(UIButton*) btnChecked checked:(bool) checked
{
    if(btnChecked.selected)
        checked=false;
    
    for(UIButton *btn in [self radioButtons])
        [btn setSelected:false];
    
    [btnChecked setSelected:checked];
}

- (IBAction)btnCheckAllTouchUpInside:(id)sender {
    for(UIView *filter in [self filters])
        [self setHighlight:true filter:filter];
}

- (IBAction)btnCheckNonTouchUpInside:(id)sender {
    for(UIView *filter in [self filters])
        [self setHighlight:false filter:filter];
}

- (IBAction)btnGetAwardTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnGetPointTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnMostLikeTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnMostViewTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnDistanceTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnDoneTouchUpInside:(id)sender {
    Filter *filter=[[DataManager shareInstance] currentUser].filter;
    
    if(!filter)
    {
        filter=[Filter insert];
        filter.user=[DataManager shareInstance].currentUser;
    }
    
    filter.food=[NSNumber numberWithBool:[self isHighlighted:food]];
    filter.drink=[NSNumber numberWithBool:[self isHighlighted:drink]];
    filter.health=[NSNumber numberWithBool:[self isHighlighted:health]];
    filter.entertaiment=[NSNumber numberWithBool:[self isHighlighted:entertaiment]];
    filter.fashion=[NSNumber numberWithBool:[self isHighlighted:fashion]];
    filter.travel=[NSNumber numberWithBool:[self isHighlighted:travel]];
    filter.production=[NSNumber numberWithBool:[self isHighlighted:production]];
    filter.education=[NSNumber numberWithBool:[self isHighlighted:education]];
    
    filter.mostGetReward=[NSNumber numberWithBool:btnAward.selected];
    filter.mostGetPoint=[NSNumber numberWithBool:btnPoint.selected];
    filter.mostLike=[NSNumber numberWithBool:btnLike.selected];
    filter.mostView=[NSNumber numberWithBool:btnView.selected];
    filter.distance=[NSNumber numberWithBool:btnDistance.selected];
    
    bool hasChange=filter.hasChanges;
    
    [[DataManager shareInstance] save];

    if([[RootViewController shareInstance].frontViewController.currentVisibleViewController isKindOfClass:[CatalogueListViewController class]])
    {
        if(hasChange)
        {
            NSMutableArray *array=[NSMutableArray array];
            if(filter.food.boolValue)
                [array addObject:[Group food]];
            if(filter.drink.boolValue)
                [array addObject:[Group drink]];
            if(filter.health.boolValue)
                [array addObject:[Group health]];
            if(filter.entertaiment.boolValue)
                [array addObject:[Group entertaiment]];
            if(filter.fashion.boolValue)
                [array addObject:[Group fashion]];
            if(filter.travel.boolValue)
                [array addObject:[Group travel]];
            if(filter.production.boolValue)
                [array addObject:[Group production]];
            if(filter.education.boolValue)
                [array addObject:[Group education]];
            
            [self.view showLoadingWithTitle:nil];
            
            [RootViewController shareInstance].frontViewController.catalogueList.delegate=self;
            [[RootViewController shareInstance].frontViewController.catalogueList loadGroups:array sortType:filter.sortBy city:[DataManager shareInstance].currentCity.idCity.integerValue];
        }
        else
            [[RootViewController shareInstance] hideFilter];
    }
//    if(hasChange)
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FILTER_CHANGED object:nil];
//    
//    if(delegate && [delegate respondsToSelector:@selector(filterDone)])
//        [delegate filterDone];
}

-(void)catalogueListLoadShopFinished:(CatalogueListViewController *)catalogueListView
{
    [self.view removeLoading];
    [[RootViewController shareInstance] hideFilter];
    catalogueListView.delegate=nil;
}

- (void)viewDidUnload {
    lblAllField = nil;
    food = nil;
    drink = nil;
    health = nil;
    entertaiment = nil;
    fashion = nil;
    travel = nil;
    production = nil;
    education = nil;
    btnAward = nil;
    btnPoint = nil;
    btnLike = nil;
    btnView = nil;
    btnDistance = nil;
    [super viewDidUnload];
}

-(NSArray *)rightNavigationItems
{
    return @[@(ITEM_FILTER),@(ITEM_COLLECTION),@(ITEM_LIST)];
}

@end

@implementation FilterButton



@end

@implementation FilterView



@end