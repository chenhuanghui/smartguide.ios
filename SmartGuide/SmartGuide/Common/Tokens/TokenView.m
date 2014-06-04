//
//  TokenView.m
//  JSTokenField
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 JamSoft. All rights reserved.
//

#import "TokenView.h"
#import "Constant.h"

@interface TokenView()<JSTokenFieldDelegate>
{
    
}

@end

@implementation TokenView

-(void)setTokens:(NSArray *)tokens
{
    [self removeAllTokens];
    
    if(tokens.count==0)
        return;
    
    NSArray *__tokens=[tokens copy];
    __tokens=[[tokens componentsJoinedByString:@"||"] componentsSeparatedByString:@"|"];
    
    for(NSString* token in __tokens)
    {
        NSAttributedString *str=[[NSAttributedString alloc] initWithString:(token.length==0?@"|":token)
                                                                attributes:@{
                                                                             NSFontAttributeName:FONT_SIZE_NORMAL(13),
                                                                             NSUnderlineStyleAttributeName:@(true)}];
        
        [self addTokenWithAttributeTitle:str representedObject:nil];
    }
    
    self.layer.transform=CATransform3DMakeScale(-1, 1, 1);
    
    for(JSTokenButton *token in self.tokens)
    {
        token.layer.transform=CATransform3DMakeScale(-1, 1, 1);
    }
}

-(void)setTokens:(NSArray *)tokens objects:(NSArray *)objs
{
    [self removeAllTokens];
    
    if(tokens.count==0)
        return;
    
    NSArray *__tokens=[tokens copy];
    __tokens=[[tokens componentsJoinedByString:@"||"] componentsSeparatedByString:@"|"];
    int count=0;
    
    for(int i=0;i<__tokens.count;i++)
    {
        NSString* token=__tokens[i];
        
        NSAttributedString *str=[[NSAttributedString alloc] initWithString:(token.length==0?@"|":token)
                                                                attributes:@{
                                                                             NSFontAttributeName:FONT_SIZE_NORMAL(13),
                                                                             NSUnderlineStyleAttributeName:@(true)}];
        
        id obj=nil;
        
        if(![str.string isEqualToString:@"|"])
            obj=objs[count++];
        
        JSTokenButton *btn=[self addTokenWithAttributeTitle:str representedObject:obj];
        
        btn.layer.transform=CATransform3DMakeScale(-1, 1, 1);
        
    }
    
    self.layer.transform=CATransform3DMakeScale(-1, 1, 1);
}

+(float)heightWithTokens:(NSArray *)tokens forWidth:(float)forWidth
{
    if(tokens.count==0)
        return 0;
    
    NSArray *_tokens=[tokens copy];
    _tokens=[[tokens componentsJoinedByString:@"||"] componentsSeparatedByString:@"|"];
    
    TokenView *txt=[[TokenView alloc] initWithFrame:CGRectMake(0, 0, forWidth, 0)];
    for(NSString *token in _tokens)
    {
        NSAttributedString *str=[[NSAttributedString alloc] initWithString:(token.length==0?@"|":token)
                                                                attributes:@{
                                                                             NSFontAttributeName:FONT_SIZE_NORMAL(13),
                                                                             NSUnderlineStyleAttributeName:@(true)}];
        
        [txt addTokenWithAttributeTitle:str representedObject:nil];
    }
    
    [txt layoutSubviews];
    
    return txt.frame.size.height;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return false;
}

-(void)toggle:(id)sender
{
    NSLog(@"toggle");
    
    JSTokenButton *btn=sender;
    
    if(btn.isSeperatorToken)
        return;
    
    self.userInteractionEnabled=false;
    [super toggle:sender];
    
    self.selectedToken=sender;
    
    if([self.delegate respondsToSelector:@selector(tokenViewTouchedToken:object:)])
        [self.delegate tokenViewTouchedToken:self object:self.selectedToken.representedObject];
    
    self.userInteractionEnabled=true;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    NSMutableArray *ys=[[self.tokens valueForKeyPath:@"@distinctUnionOfObjects.y"] mutableCopy];
    
    for(NSNumber *y in ys)
    {
        NSArray *tokenY=[self.tokens filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"y==%@",y]];
        
        if(tokenY.count>0)
        {
            JSTokenButton *btn=[tokenY lastObject];
            btn.hidden=btn.isSeperatorToken;
            
            btn=[tokenY firstObject];
            btn.hidden=btn.isSeperatorToken;
        }
    }
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(self.tokens.count==0)
        return false;
    
    bool isPointInside=[super pointInside:point withEvent:event];
    
    if(isPointInside)
    {
        for(JSTokenButton *btn in self.tokens)
        {
            if([btn pointInside:[self convertPoint:point toView:btn] withEvent:event])
                return true;
        }
    }
    
    return false;
}

@end