//
//  AvatarCell.h
//  SmartGuide
//
//  Created by MacMini on 06/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarCell : UITableViewCell
{
    NSString *_url;
    __weak IBOutlet UIImageView *imgv;
    
}

-(void) loadWithURL:(NSString*) url;
-(NSString*) url;

+(NSString *)reuseIdentifier;

@end
