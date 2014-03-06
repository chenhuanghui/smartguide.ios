//
//  HomeImageType9Cell.h
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHome.h"
#import "ImageScaleCrop.h"

@interface HomeImageType9Cell : UITableViewCell
{
    __weak IBOutlet ImageScaleCropAspectFit *imgv;
}

-(void) loadWithURL:(NSString*) url width:(float) width height:(float) height;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak,readwrite) UITableView *table;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak, readwrite) UserHome *home;

@end