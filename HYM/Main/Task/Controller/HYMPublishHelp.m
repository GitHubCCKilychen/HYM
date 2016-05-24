//
//  HYMPublishHelp.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishHelp.h"

@interface HYMPublishHelp ()<UIWebViewDelegate>
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@end

@implementation HYMPublishHelp

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initDefatult];
    [self addWebView];
}


- (void)initDefatult{
    
    self.title = @"帮助";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /*
     *  帮助详情页
     http://123.56.237.91/index.php/new/show_help/id/11
     参数   get方式提交
     id     帮助的详情id
     /*
     
     需要帮助的列表页面、审核报单的列表页面
     http://123.56.237.91/index.php/new/help_list/type/3
     参数  get方式提交
     type   帮助类型 1、任务帮助；2、邀请帮助；3、人脉帮助；4、需要帮助；5、审核报单帮助
     */
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
