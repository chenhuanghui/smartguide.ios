//
//  ViewController.m
//  SGScrollView
//
//  Created by MacMini on 10/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [scroll pauseView:v1 minY:10];
    [scroll setContentSize:CGSizeMake(320, 2000)];
    
    [scroll pauseView:table minY:100];
    
    table.dataSource=self;
    table.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.backgroundColor=[UIColor greenColor];
    cell.textLabel.text=[NSString stringWithFormat:@"%@",indexPath];
    cell.textLabel.font=[UIFont systemFontOfSize:8];
    
    return cell;
}

@end
