//
//  HYMHelpVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMHelpVC.h"

@interface HYMHelpVC ()<UIWebViewDelegate>
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@end

@implementation HYMHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefatult];
    [self addWebView];
}

- (void)initDefatult{

    self.title = @"帮助";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)addWebView{
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    webView.scalesPageToFit=YES;
    webView.delegate = self;
    
    NSString *path = @"http://123.56.237.91/index.php/new/help_list/type/3";
    NSURL *url = [NSURL URLWithString:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    
    
}
#pragma mark webview代理
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [_activity setCenter:view.center];
    [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:_activity];
    
    [_activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [_activity stopAnimating];
    
    UIView *view = (UIView *)[self.view viewWithTag:108];
    
    [view removeFromSuperview];
}
#pragma mark 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [_activity stopAnimating];
    
    UIView *view = (UIView *)[self.view viewWithTag:107];
    
    [view removeFromSuperview];
    
}

@end
