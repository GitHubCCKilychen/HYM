//
//  HYMCommBlogVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommBlogVC.h"
#import "HYMTaskBottom.h"
@interface HYMCommBlogVC ()<UIWebViewDelegate>

@property (nonatomic,strong)HYMTaskBottom *bottom;
@property (nonatomic,weak)UITextField *textField;
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@property (nonatomic,copy)NSString *pathUrl;
@end

@implementation HYMCommBlogVC


- (HYMTaskBottom *)bottom{
    
    if (_bottom == nil) {
        
        _bottom = [[[NSBundle mainBundle] loadNibNamed:@"HYMTaskBottom" owner:self options:nil] lastObject];
        _bottom.frame = CGRectMake(0, kScreenHeight - 49, kScreenWitdth, 49);
    }
    return _bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDefalut];
    [self initWithView];
    [self addWebView];
}



- (void)initDefalut{

    self.title = @"帖子详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *report = [UIButton buttonWithType:UIButtonTypeCustom];
    report.frame = CGRectMake(0, 0,30, 30);
    [report setTitle:@"举报" forState:UIControlStateNormal];
    report.titleLabel.font = [UIFont systemFontOfSize:15];
    [report setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [report addTarget:self action:@selector(reportAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:report];
    
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0, 0, 20, 20);
    [messageBtn setImage:[UIImage imageNamed:@"任务消息"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:messageBtn];
    
    
    UIBarButtonItem *reportItem = [[UIBarButtonItem alloc] initWithCustomView:report];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    
    self.navigationItem.rightBarButtonItems = @[messageItem,reportItem];
    
}

- (void)initWithView{

    [self.view addSubview:self.bottom];
    
}

- (void)setIndex:(NSString *)index{

    _index = index;
    //blogID－－根据这个来判断
   
}
- (void)addWebView{
  
    
    NSLog(@"%@",self.index);
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 64, kScreenWitdth, kScreenHeight-49-64);
    webView.scalesPageToFit=YES;
    webView.delegate = self;
    
    NSString *path = @"http://123.56.237.91/index.php/blog/show/blog_id/";
    NSString *string = [NSString stringWithFormat:@"%@%@",path,self.index];
    NSURL *url = [NSURL URLWithString:string];
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

#pragma mark 举报
- (void)reportAct:(UIButton *)btn{
    
    //此处需不需要做判断版本
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要举报该话题" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入要举报的原因";
        self.textField = textField;
    }];

    [self.view.viewController presentViewController:alert animated:YES completion:nil];
    
    
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //此处获取textfiled的值
//        NSLog(@"%@",self.textField.text);
        
    }];
    
    UIAlertAction *cancle = [UIAlertAction  actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alert addAction:sureBtn];
    [alert addAction:cancle];
}

@end
