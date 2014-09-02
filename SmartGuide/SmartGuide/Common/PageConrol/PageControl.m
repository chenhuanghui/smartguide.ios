//
//  PageControl.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PageControl.h"
#import "Utility.h"

@implementation PageControl

@synthesize dotColorCurrentPage;
@synthesize dotColorOtherPage;
@synthesize currentPage;
@synthesize numberOfPages;
@synthesize delegate;

- (void)setCurrentPage:(NSInteger)page
{
    if(currentPage==page)
        return;
    
    currentPage = MIN(MAX(0, page), self.numberOfPages-1);
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)pages
{
    numberOfPages = MAX(0, pages);
    currentPage = MIN(MAX(0, self.currentPage), numberOfPages-1);
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Default colors.
        self.backgroundColor = [UIColor clearColor];
        [self initComponents];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initComponents];
    }
    return self;
}

-(void) initComponents
{
    self.dotColorCurrentPage = [UIColor blackColor];
    self.dotColorOtherPage = [UIColor lightGrayColor];
    self.kDotDiameter=7.f;
    self.kDotSpacer=7.0f;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true);
    
    CGRect currentBounds = self.bounds;
    CGFloat dotsWidth = self.numberOfPages*_kDotDiameter + MAX(0, self.numberOfPages-1)*_kDotSpacer;
    CGFloat x = CGRectGetMidX(currentBounds)-dotsWidth/2;
    CGFloat y = CGRectGetMidY(currentBounds)-_kDotDiameter/2;
    for (int i=0; i<self.numberOfPages; i++)
    {
        
        if (i == self.currentPage)
        {
            [self drawDotCurrentPage:context atPoint:CGPointMake(x, y)];
        }
        else
        {
            [self drawDotOtherPage:context atPoint:CGPointMake(x, y)];
        }
        
        
        x += _kDotDiameter + _kDotSpacer;
    }
}

-(void)drawDotCurrentPage:(CGContextRef)context atPoint:(CGPoint)pnt
{
    CGRect circleRect = CGRectMake(pnt.x, pnt.y, _kDotDiameter, _kDotDiameter);
    CGContextSetFillColorWithColor(context, self.dotColorCurrentPage.CGColor);
    CGContextFillEllipseInRect(context, circleRect);
}

-(void)drawDotOtherPage:(CGContextRef)context atPoint:(CGPoint)pnt
{
    CGRect circleRect = CGRectMake(pnt.x, pnt.y, _kDotDiameter, _kDotDiameter);
    CGContextSetFillColorWithColor(context, self.dotColorOtherPage.CGColor);
    CGContextFillEllipseInRect(context, circleRect);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.delegate) return;
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
    
    CGFloat dotSpanX = self.numberOfPages*(_kDotDiameter + _kDotSpacer);
    CGFloat dotSpanY = _kDotDiameter + _kDotSpacer;
    
    CGRect currentBounds = self.bounds;
    CGFloat x = touchPoint.x + dotSpanX/2 - CGRectGetMidX(currentBounds);
    CGFloat y = touchPoint.y + dotSpanY/2 - CGRectGetMidY(currentBounds);
    
    if ((x<0) || (x>dotSpanX) || (y<0) || (y>dotSpanY)) return;
    
    int page=floor(x/(_kDotDiameter+_kDotSpacer));
    
    if(self.currentPage!=page)
    {
        self.currentPage=page;
        if ([self.delegate respondsToSelector:@selector(pageControlPageDidChange:)])
        {
            [self.delegate pageControlPageDidChange:self];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView scrollDirection:(UICollectionViewScrollDirection) direction
{
    if(direction==UICollectionViewScrollDirectionHorizontal)
        self.currentPage=scrollView.contentOffset.x/scrollView.frame.size.width;
    else
        self.currentPage=[scrollView currentPage];
}

-(void)setScroll:(UIScrollView *)scroll
{
    if(_scroll)
        [_scroll removeObserver:self forKeyPath:@"contentOffset"];
    
    _scroll=scroll;
    
    if(_scroll)
    {
        [_scroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self scrollViewDidScroll:scroll scrollDirection:_scrollDirection];
    }
}

-(void)dealloc
{
    self.scroll=nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self scrollViewDidScroll:object scrollDirection:_scrollDirection];
}

-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection=scrollDirection;
    
    if(_scroll)
        [self scrollViewDidScroll:_scroll scrollDirection:scrollDirection];
}

@end

@implementation PageControlNext

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true);
    
    int numOfPage=self.numberOfPages;
    
    if(numOfPage>5)
        numOfPage=5;
    
    CGRect currentBounds = self.bounds;
    CGFloat dotsWidth = numOfPage*self.kDotDiameter + MAX(0, numOfPage-1)*self.kDotSpacer;
    CGFloat x = CGRectGetMidX(currentBounds)-dotsWidth/2;
    CGFloat y = CGRectGetMidY(currentBounds)-self.kDotDiameter/2;
    
    if(self.numberOfPages>5)
    {
        rect=CGRectMake(x, y, self.kDotDiameter, self.kDotDiameter);
        
        if(self.currentPage>=4)
            [self drawLeftArrow:rect];
        else
            [self drawPage:context rect:rect page:0];
        
        rect.origin.x += self.kDotDiameter + self.kDotSpacer;
        [self drawPage:context rect:rect page:1];
        rect.origin.x += self.kDotDiameter + self.kDotSpacer;
        [self drawPage:context rect:rect page:2];
        rect.origin.x += self.kDotDiameter + self.kDotSpacer;
        
        if(self.currentPage==self.numberOfPages-1)
            [self drawOtherPage:context rect:rect];
        else if(self.currentPage>=4)
            [self drawCurrentPage:context rect:rect];
        else
            [self drawPage:context rect:rect page:3];
        
        rect.origin.x += self.kDotDiameter + self.kDotSpacer;
        
        if(self.currentPage==self.numberOfPages-1)
            [self drawCurrentPage:context rect:rect];
        else
            [self drawRightArrow:rect];
        
        return;
    }
    
    for (int i=0; i<numOfPage; i++)
    {
        CGRect circleRect = CGRectMake(x, y, self.kDotDiameter, self.kDotDiameter);
        
        if (i == self.currentPage)
        {
            CGContextSetFillColorWithColor(context, self.dotColorCurrentPage.CGColor);
        }
        else
        {
            CGContextSetFillColorWithColor(context, self.dotColorOtherPage.CGColor);
        }
        CGContextFillEllipseInRect(context, circleRect);
        x += self.kDotDiameter + self.kDotSpacer;
    }
}

-(void) drawPage:(CGContextRef) context rect:(CGRect) rect page:(int) page
{
    if(self.currentPage==page)
        [self drawCurrentPage:context rect:rect];
    else
        [self drawOtherPage:context rect:rect];
}

-(void) drawCurrentPage:(CGContextRef) context rect:(CGRect) rect
{
    CGContextSetFillColorWithColor(context, self.dotColorCurrentPage.CGColor);
    CGContextFillEllipseInRect(context, rect);
}

-(void) drawOtherPage:(CGContextRef) context rect:(CGRect) rect
{
    CGContextSetFillColorWithColor(context, self.dotColorOtherPage.CGColor);
    CGContextFillEllipseInRect(context, rect);
}

-(void) drawLeftArrow:(CGRect) rect
{
    UIImage *img=[UIImage imageNamed:@"button_arrow.png"];
    
    rect.origin.y=(self.l_v_h-img.size.height)/2;
    
    UIImage *imgLeft =[[UIImage alloc] initWithCGImage:img.CGImage scale:2 orientation:UIImageOrientationDown];
    
    [imgLeft drawAtPoint:rect.origin];
}

-(void) drawRightArrow:(CGRect) rect
{
    UIImage *img=[UIImage imageNamed:@"button_arrow.png"];
    rect.origin.y=(self.l_v_h-img.size.height)/2;
    
    [img drawAtPoint:rect.origin];
}

-(void) btn:(UIButton*) sender
{
    [self.delegate pageControlTouchedNext:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.delegate) return;
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
    
    int numOfPage=self.numberOfPages>0?self.numberOfPages+1:0;
    
    CGFloat dotSpanX = numOfPage*(self.kDotDiameter + self.kDotSpacer);
    CGFloat dotSpanY = self.kDotDiameter + self.kDotSpacer;
    
    CGRect currentBounds = self.bounds;
    CGFloat x = touchPoint.x + dotSpanX/2 - CGRectGetMidX(currentBounds);
    CGFloat y = touchPoint.y + dotSpanY/2 - CGRectGetMidY(currentBounds);
    
    if ((x<0) || (x>dotSpanX) || (y<0) || (y>dotSpanY)) return;
    
    int page=floor(x/(self.kDotDiameter+self.kDotSpacer));
    
    if(page==numOfPage-1)
    {
        [self.delegate pageControlTouchedNext:self];
        return;
    }
    
    if(self.currentPage!=page)
    {
        self.currentPage=page;
        if ([self.delegate respondsToSelector:@selector(pageControlPageDidChange:)])
        {
            [self.delegate pageControlPageDidChange:self];
        }
    }
}

@end

@implementation PageControlShopGallery

-(void)drawDotOtherPage:(CGContextRef)context atPoint:(CGPoint)pnt
{
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(pnt.x, pnt.y, self.kDotDiameter, self.kDotDiameter));
}

-(void)drawDotCurrentPage:(CGContextRef)context atPoint:(CGPoint)pnt
{
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextStrokeEllipseInRect(context, CGRectMake(pnt.x-_lineWidth, pnt.y-_lineWidth, self.kDotDiameter+_lineWidth*2, self.kDotDiameter+_lineWidth*2));
}

-(void)initComponents
{
    [super initComponents];
    _lineWidth=3;
}

@end