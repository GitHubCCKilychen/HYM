//
//  HYMCommentVC.m
//  资讯
//
//  Created by 刘晓雪 on 16/4/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommentVC.h"


@interface HYMCommentVC ()<UITextViewDelegate,HYMCommentDelagete>

@property (nonatomic,strong)UITextView *textView;

@property (nonatomic,assign)int index;
@end

@implementation HYMCommentVC

-(UITextView *)textView{

    if (_textView == nil) {
        
        _textView = [[UITextView alloc] init];
        _textView.frame = CGRectMake(0, 64, self.view.frame.size.width, 200);
        _textView.backgroundColor = [UIColor lightGrayColor];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.delegate = self;
    }
    
    return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"写评论";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;//光标位置调整
    [self.view addSubview:self.textView];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneAct:)];
    
    self.navigationItem.rightBarButtonItem = done;
    self.commentDelegate = self;
    self.index++;
}

#pragma mark 完成事件
- (void)doneAct:(UIButton *)btn{

    self.commont = self.textView.text;
    
    
    if ([self.commentDelegate respondsToSelector:@selector(comment:with:)]) {
        
        [self.commentDelegate comment:self.commont with:self.index+1];
        
        
    }
    
    
//返回前这页面
    [self.view.viewController.navigationController popViewControllerAnimated:YES];
    
    
    //调用接口
    NSDictionary *money = @{@"keyid":@"7786",@"ordertype":@"1",@"keytype":@"2",@"page":@"0"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:money];
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/reply_list" target:self selector:@selector(infoData:) parameter:nsdic];
}

- (void)infoData:(NSDictionary *)dic{

    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
}

- (void)comment:(NSString *)text with:(int)indexCount{
    
    text = self.commont;
    indexCount = self.index;
//    
//    NSLog(@"%d",indexCount);
}

#pragma  mark textViewDelegate
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//
//    [textView becomeFirstResponder];
//    return YES;
//}
//
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//
//    [textView resignFirstResponder];
//    return YES;
//}

#pragma mark 协议实现


@end
