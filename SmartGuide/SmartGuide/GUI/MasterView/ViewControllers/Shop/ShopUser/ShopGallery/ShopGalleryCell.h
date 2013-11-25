//
//  ShopGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopGalleryCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UILabel *llbbll;
}

-(void) loadImage:(NSString*) url;
-(void) setLbl:(NSString*) text;
+(NSString *)reuseIdentifier;

@end
