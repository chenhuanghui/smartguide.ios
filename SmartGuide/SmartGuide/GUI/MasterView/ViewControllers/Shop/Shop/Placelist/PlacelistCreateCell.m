//
//  PlacelistCreateCell.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PlacelistCreateCell.h"

@implementation PlacelistCreateCell

-(void)loadWithMode:(enum PLACELIST_CREATE_CELL_MODE)mode
{
    switch (mode) {
        case PLACELIST_CREATE_CELL_SMALL:
            btnCreate.hidden=true;
            txtDesc.hidden=true;
            break;
            
        default:
            btnCreate.hidden=false;
            txtDesc.hidden=false;
            break;
    }
}

+(NSString *)reuseIdentifier
{
    return @"PlacelistCreateCell";
}

+(float)heightWithMode:(enum PLACELIST_CREATE_CELL_MODE)mode
{
    switch (mode) {
        case PLACELIST_CREATE_CELL_SMALL:
            return 44+14;
            
        case PLACELIST_CREATE_CELL_DETAIL:
            return 155+14;
    }
}

- (IBAction)btnCreateTouchUpInside:(id)sender {
}

@end
