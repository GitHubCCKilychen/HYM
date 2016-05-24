//
//  HYMFormDetails.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFormDetails.h"

@interface HYMFormDetails ()<UIWebViewDelegate>

@property (nonatomic,strong)UIActivityIndicatorView *activity;
@end

@implementation HYMFormDetails

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initDefault];
    [self addWebView];
}

- (void)initDefault{

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"报单详情";

     [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)addWebView{
    
    //此处还没做修改－－导航栏
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    webView.delegate = self;
    
    NSString *path = @"http://123.56.237.91/index.php/new/sign_check_list/task_id/31";
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
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear: animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear: animated];
    
    self.navigationController.navigationBar.hidden =  NO;
}
@end
