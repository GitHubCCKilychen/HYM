//
//  HYMTask2Deatail.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTask2Deatail.h"

@implementation HYMTask2Deatail

#pragma mark 懒加载

- (UIButton *)btn{
    if (_btn == nil) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor grayColor];
        [_btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
    
}
-(UIView *)lineView{
    
    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.layer.cornerRadius = 4;
        
    }
    return _lineView;
}

-(UILabel *)activity{
    
    if (_activity == nil) {
        
        _activity = [[UILabel alloc] init];
        _activity.text= @"活动简介";
        [HYMTool initLabel:_activity withFont:[UIFont boldSystemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
        [_activityContent sizeToFit];
    }
    return _activity;
}

- (UILabel *)activityContent{
    
    if (_activityContent == nil) {
        
        _activityContent = [[UILabel alloc] init];
        _activityContent.numberOfLines = 0;
        _activityContent.text = @"通过活动链接注册完成认证及投资，投资100元（充值90元，勾选10元红包）新手15天收益10元";
        [HYMTool initLabel:_activityContent withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _activityContent;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}



- (void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
    
    if (_indexPath.row < 2) {
        
        [self addSubview:self.lineView];
        [self addSubview:self.activity];
        [self addSubview:self.activityContent];
        
        //左侧15上册10
        self.lineView.backgroundColor = [UIColor orangeColor];
        self.lineView.sd_layout
        .leftSpaceToView(self,15).topSpaceToView(self,10)
        .widthIs(8).heightIs(20);
        
        self.activity.sd_layout
        .topEqualToView(self.lineView).leftSpaceToView(self.lineView,10)
        .widthIs(80).heightIs(20);
        
        self.activityContent.sd_layout
        .leftSpaceToView(self,15).rightSpaceToView(self,10)
        .topSpaceToView(self.activity,10).heightIs(40);
    }
    
    if (_indexPath.row == 1) {
        
        self.activity.text = @"任务教程";
        self.activityContent.text = @"通过活动链接注册完成认证及投资，投资100元（充值90元，勾选10元红包）新手15天收益10元";
        
        
        [self addSubview:self.btn];
        self.btn.backgroundColor = [UIColor redColor];
        self.btn.sd_layout
        .rightSpaceToView(self,50).bottomSpaceToView(self,10)
        .heightIs(20).widthIs(20);
    }
        
}

- (void)initWithBtn{
    
  
}

#pragma mark 展开
- (void)btnAct:(UIButton *)btn{

    //调用web展示
    //此处展开又问题
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.viewController.view.frame;
    webView.scalesPageToFit=YES;
    webView.delegate = self;
    
    NSString *path = @"http://123.56.237.91/index.php/blog/show/blog_id/7034";
    NSURL *url = [NSURL URLWithString:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//    [self addSubview:webView];
    
}
#pragma mark webview代理
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    UIView *view = [[UIView alloc] initWithFrame:self.viewController.view.bounds];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self addSubview:view];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [self.activityView setCenter:view.center];
    [self.activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:self.activity];
    
    [self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activityView stopAnimating];
    
    UIView *view = (UIView *)[self viewWithTag:108];
    
    [view removeFromSuperview];
}
#pragma mark 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.activityView stopAnimating];
    
    UIView *view = (UIView *)[self viewWithTag:107];
    
    [view removeFromSuperview];
    
}
@end
