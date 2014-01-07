//
//  AvatarViewController.m
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AvatarViewController.h"
#import "AvatarCell.h"

@interface AvatarViewController ()

@end

@implementation AvatarViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"AvatarViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    touchView.receiveView=table;
    
    _avatars=[NSMutableArray new];
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TABLE);
    table.frame=rect;

    [table registerNib:[UINib nibWithNibName:[AvatarCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[AvatarCell reuseIdentifier]];
    
    for(int i=0;i<20;i++)
    {
        [_avatars addObject:@""];
    }
    
    table.clipsToBounds=false;
    
    table.contentInset=UIEdgeInsetsMake(0, 0, 1, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnUpPhotoTouchUpInside:(id)sender {
}

- (IBAction)btnConfirmTouchUpInside:(id)sender {
    
    CGPoint pnt=CGPointMake(table.l_co_y+160, table.l_v_h/2);
    
    NSIndexPath *indexPath=[table indexPathForRowAtPoint:pnt];
    
    AvatarCell *cell=(AvatarCell*)[table cellForRowAtIndexPath:indexPath];
    
    [self.delegate avatarControllerTouched:self avatar:cell.url];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _avatars.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _avatars.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AvatarCell *cell=[tableView dequeueReusableCellWithIdentifier:[AvatarCell reuseIdentifier]];
    
    [cell loadWithURL:_avatars[indexPath.row]];
    
    return cell;
}

@end