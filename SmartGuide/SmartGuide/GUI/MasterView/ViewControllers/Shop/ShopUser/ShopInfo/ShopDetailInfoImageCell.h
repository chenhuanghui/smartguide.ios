//
//  ShopDetailInfoImageCell.h
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailInfoImageCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
}

-(void) loadWithImage:(UIImage*) image withTitle:(NSString*) title withContent:(NSString*) content;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end
