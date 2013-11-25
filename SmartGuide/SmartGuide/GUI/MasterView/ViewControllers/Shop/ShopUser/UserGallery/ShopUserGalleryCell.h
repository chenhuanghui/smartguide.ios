//
//  ShopUserGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopUserGalleryCell : UITableViewCell
{
    IBOutlet UIImageView *imgv;
    IBOutlet UILabel *llb;
}

-(void) setLLB:(NSString*) text;

+(NSString *)reuseIdentifier;
+(float) height;

@end
