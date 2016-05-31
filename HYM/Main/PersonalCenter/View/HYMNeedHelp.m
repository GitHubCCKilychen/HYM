//
//  HYMNeedHelp.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/26.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMNeedHelp.h"

@interface HYMNeedHelp ()<UIWebViewDelegate>
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@end

@implementation HYMNeedHelp

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self addWebView];
}

- (void)setIndexString:(NSString *)indexString{

    _indexString = indexString;
    
    int index = [_indexString intValue];
    
    switch (index) {
        case 0:
            self.title = @"帮助";
            break;
        case 1:
            self.title = @"任务帮助";
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            self.title = @"需要帮助";
            break;
        case 5:
            self.title = @"审核报单";
        default:
            break;
    }
}
- (void)initDefault{
   
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)addWebView{
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    webView.scalesPageToFit=YES;
    webView.delegate = self;
    NSString *path = @"http://123.56.237.91/index.php/new/help_list/type/";
    NSString *pathurl = [NSString stringWithFormat:@"%@%@",path,self.indexString];
    NSURL *url = [NSURL URLWithString:pathurl];
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
