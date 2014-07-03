//
//  ScanResultRelatedCell.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanCodeRelatedContain;

@class MPMoviePlayerController, ScanResultRelatedCell, ScanCodeRelated;

@protocol ScanResultRelatedCellDelegate <NSObject>

-(void) scanResultRelatedCell:(ScanResultRelatedCell*) cell touchedObject:(ScanCodeRelated*) obj;

@end

@interface ScanResultRelatedCell : UITableViewCell
{
    __weak IBOutlet UITableView *table;
    ScanCodeRelatedContain *_relatedContain;
}

-(void) loadWithRelatedContain:(ScanCodeRelatedContain*) relatedContain;

+(float) heightWithRelated:(ScanCodeRelatedContain*) relatedContain;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ScanResultRelatedCellDelegate> delegate;

@end

@interface UITableView(ScanResultRelatedCell)

-(void) registerScanResultRelatedCell;
-(ScanResultRelatedCell*) scanResultRelatedCell;

@end