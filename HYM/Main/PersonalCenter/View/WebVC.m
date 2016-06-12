//
//  WebVC.m
//  BAOWEN
//
//  Created by 平川嘉恒 on 13-10-14.
//  Copyright (c) 2013年 平川嘉恒. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()<UIWebViewDelegate>
@end

@implementation WebVC
@synthesize urlPath;
@synthesize objectTitle;
@synthesize isAdgust;
@synthesize myWebView;
@synthesize isPresent;

- (void)dealloc
{
    [urlPath release];urlPath = nil;
    [objectTitle release];objectTitle = nil;
    [myWebView release];myWebView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSet];
}
- (void)loadSet
{
    
    [self.navigationItem setNewTitle:objectTitle];
    [self.view setBackgroundColor:BB_Back_Color_Here];
   
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    
    
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght)];
    [self.view addSubview:myWebView];
    [myWebView release];
    myWebView.delegate = self;
    
    NSString *path = urlPath?urlPath:@"http://www.baidu.com";
   
    
    NSURL *url = [NSURL URLWithString:path];
    [myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    if (isAdgust)
    {
        [myWebView setScalesPageToFit:YES];
    }else
    {
        [myWebView setScalesPageToFit:NO];
    }
    

}

-(void)leftBtnPressed:(id)sender
{
    if (isPresent)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)backbtnPressed:(id)sender
{
    if (myWebView.canGoBack)
    {
        [myWebView goBack];
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    return;
    
    float one = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] floatValue];
    float two = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    float three = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    float four = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollTop"] floatValue];
    float five = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.height"] floatValue];
    float six = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.availHeight"] floatValue];
    
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    
    NSLog(@"高度：%f,%f,%f,%f,%f,%f,%f,%f",one,two,three,four,five,six,fittingSize.height,webViewHeight);
   
}
@end
