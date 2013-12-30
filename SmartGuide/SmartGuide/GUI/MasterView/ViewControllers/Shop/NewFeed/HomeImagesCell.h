//
//  NewFeedImagesCell.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeImagesCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_images;
    __weak IBOutlet UITableView *table;
}

-(void) loadWithImages:(NSArray*) images;

+(float) height;
+(NSString *)reuseIdentifier;

@end
