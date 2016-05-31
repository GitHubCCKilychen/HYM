//
//  HYMBlogVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMBlogVC.h"
#import "HYMTaskBottom.h"
@interface HYMBlogVC ()<UIWebViewDelegate>
@property (nonatomic,strong)HYMTaskBottom *bottom;
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@end

@implementation HYMBlogVC

- (HYMTaskBottom *)bottom{

    if (_bottom == nil) {
        
        _bottom = [[[NSBundle mainBundle]loadNibNamed:@"HYMTaskBottom" owner:self options:nil] lastObject];
        _bottom.frame = CGRectMake(0, kScreenHeight-49, kScreenWitdth, 49);
    }
    return _bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self addWebView];
}

- (void)initDefault{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"今日资讯";
    
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}


- (void)setBlogID:(int)blogID{

    _blogID = blogID;
    NSLog(@"%d",_blogID);
}
- (void)addWebView{
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    webView.scalesPageToFit=YES;
    webView.delegate = self;
    
    //ID是什么－－此处有错误－－－
    NSString *blogID = [NSString stringWithFormat:@"%d",self.blogID];
    NSString *path = @"http://123.56.237.91/index.php/blog/show/blog_id/7786";
    NSString *pathUrl = [NSString stringWithFormat:@"%@%@",path,blogID];
    NSURL *url = [NSURL URLWithString:pathUrl];
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
//- (void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear: animated];
//    
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    
//    [super viewDidDisappear: animated];
//    
//    self.navigationController.navigationBar.hidden =  NO;
//}


@end
