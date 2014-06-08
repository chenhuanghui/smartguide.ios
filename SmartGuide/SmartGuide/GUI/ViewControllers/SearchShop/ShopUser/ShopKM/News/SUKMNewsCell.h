//
//  SUKMNewsCell.h
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionNews.h"
#import "LabelTopText.h"
#import <AVFoundation/AVFoundation.h>
#import "MoviePlayerThumbnail.h"

@class SUKMNewsCell;

@protocol SUKMNewsCellDelegate <NSObject>

-(MPMoviePlayerController*) SUKMNewsCellRequestPlayer:(SUKMNewsCell*) cell;

@end

@interface SUKMNewsCell : UITableViewCell
{
    __weak IBOutlet UIView *containView;
    __weak IBOutlet UIImageView *cover;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet LabelTopText *lblContent;
    __weak IBOutlet UIImageView *lineStatus;
    __weak IBOutlet UILabel *lblDuration;
    __weak IBOutlet UIView *videoContain;
    __weak IBOutlet UIImageView *imgvMovieThumbnail;
    __weak IBOutlet UIView *movieBGView;
    PromotionNews *_km;
}

-(void) loadWithPromotionNews:(PromotionNews*) news;
-(void) hideLine;

+(NSString *)reuseIdentifier;
+(float) heightWithPromotionNews:(PromotionNews*) news;

@property (nonatomic, weak) id<SUKMNewsCellDelegate> delegate;

@end

@interface UITableView(SUKMNewsCell)

-(void) registerSUKMNewsCell;
-(SUKMNewsCell*) SUKMNewsCell;

@end