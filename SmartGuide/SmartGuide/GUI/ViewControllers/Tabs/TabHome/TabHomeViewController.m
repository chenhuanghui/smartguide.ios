//
//  TabHomeViewController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabHomeViewController.h"
#import "HomeDataManager.h"
#import "EventDataManager.h"

enum TABHOME_MODE
{
    TABHOME_MODE_HOME=0,
    TABHOME_MODE_EVENT=1,
};

@interface TabHomeViewController ()<UITableViewDataSource, UITableViewDelegate, HomeDataDelegate, EventDataDelegate>

@property (nonatomic, assign) enum TABHOME_MODE mode;
@property (nonatomic, strong) HomeDataManager *homeManager;
@property (nonatomic, strong) EventDataManager *eventManager;

@end

@implementation TabHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mode=TABHOME_MODE_HOME;
    
    self.homeManager=[HomeDataManager manager];
    [self.homeManager addObserver:self];
    
    self.eventManager=[EventDataManager manager];
    [self.eventManager addObserver:self];
}

-(void)homeDataFinished:(HomeDataManager *)dataManager
{
    
}

-(void)homeDataFailed:(HomeDataManager *)dataManager
{
    
}

-(void)eventDataFinished:(EventDataManager *)dataManager
{
    
}

-(void)eventDataFailed:(EventDataManager *)dataManager
{
    
}

-(void) switchToMode:(enum TABHOME_MODE) mode
{
    self.mode=mode;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_mode) {
        case TABHOME_MODE_HOME:
            return MIN(_homeManager.homes.count,1);
            
        case TABHOME_MODE_EVENT:
            return MIN(_eventManager.events.count,1);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_mode) {
        case TABHOME_MODE_HOME:
            return _homeManager.homes.count;
            
        case TABHOME_MODE_EVENT:
            return _eventManager.events.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
