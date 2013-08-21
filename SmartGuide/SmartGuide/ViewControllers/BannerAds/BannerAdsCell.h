//
//  BannerAdsCell.h
//  SmartGuide
//
//  Created by XXX on 8/14/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerAdsCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UILabel *lblPage;
}

-(void)setURL:(NSString *)urlStr page:(int) page completed:(void (^)())onCompleted;

+(NSString *)reuseIdentifier;
+(CGSize) size;

@end
