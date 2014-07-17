//
//  TutorialViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "WebViewController.h"
#import "GUIManager.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

-(WebViewController *)initWithURL:(NSURL *)url
{
    self = [super initWithNibName:@"WebViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _url=[url copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSURLRequest *request=[NSURLRequest requestWithURL:_url];
    [self.webview loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    if([self.webview canGoBack])
        [self.webview goBack];
    else
    {
        [self.delegate webviewTouchedBack:self];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [webView showLoading];
    
    return true;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [webView removeLoading];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView removeLoading];
}

@end

@implementation UIViewController(WebView)

-(void)showWebViewWithURL:(NSURL *)url onCompleted:(void(^)(WebViewController* webviewController)) completed
{
    WebViewController *vc=[[WebViewController alloc] initWithURL:url];
    vc.delegate=self;
    
    [self presentSGViewController:vc animation:^BasicAnimation *{
        BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"position"];
        
        CGPoint pnt=vc.view.layer.position;
        animation.fromValue=[NSValue valueWithCGPoint:CGPointMake(vc.view.layer.position.x, vc.view.layer.position.y+vc.view.l_v_h)];
        animation.toValue=[NSValue valueWithCGPoint:pnt];
        animation.fillMode=kCAFillModeForwards;
        animation.removedOnCompletion=true;
        animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        return animation;
    } completion:^{
        if(completed)
            completed(vc);
    }];
}

-(void)webviewTouchedBack:(WebViewController *)controller
{
    [self dismissWebView];
}

-(void)dismissWebView
{
    if(self.presentSGViewControlelr && [[self presentSGViewControlelr] isKindOfClass:[WebViewController class]])
    {
        [self dismissSGViewControllerAnimation:^BasicAnimation *{
            BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"position"];
            
            animation.fromValue=[NSValue valueWithCGPoint:self.presentSGViewControlelr.view.layer.position];
            animation.toValue=[NSValue valueWithCGPoint:CGPointMake(self.presentSGViewControlelr.view.layer.position.x, self.presentSGViewControlelr.view.layer.position.y+self.presentSGViewControlelr.view.l_v_h)];
            animation.fillMode=kCAFillModeForwards;
            animation.removedOnCompletion=true;
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            return animation;
        } completion:nil];
    }
}

@end