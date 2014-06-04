//
//  TokenView.h
//  JSTokenField
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 JamSoft. All rights reserved.
//

#import "JSTokenField.h"
#import "JSTokenButton.h"

@class TokenView;

@protocol TokenViewDelegate <JSTokenFieldDelegate>

@optional
-(void) tokenViewTouchedToken:(TokenView*) token object:(id) obj;

@end

@interface TokenView : JSTokenField

-(void) setTokens:(NSArray*) tokens;
-(void) setTokens:(NSArray*) tokens objects:(NSArray*) objs;
+(float) heightWithTokens:(NSArray*) tokens forWidth:(float) forWidth;

@property (nonatomic, weak) JSTokenButton *selectedToken;
@property (nonatomic, weak) IBOutlet id<TokenViewDelegate> delegate;

@end