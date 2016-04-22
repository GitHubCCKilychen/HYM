//
//  HYMCommentVC.m
//  资讯
//
//  Created by 刘晓雪 on 16/4/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommentVC.h"

@interface HYMCommentVC ()

@property (nonatomic,strong)UITextView *textView;

@end

@implementation HYMCommentVC

-(UITextView *)textView{

    if (_textView == nil) {
        
        _textView = [[UITextView alloc] init];
        _textView.frame = CGRectMake(0, 64, self.view.frame.size.width, 200);
        _textView.backgroundColor = [UIColor lightGrayColor];
        _textView.font = [UIFont systemFontOfSize:16];
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
}

#pragma mark 完成事件
- (void)doneAct:(UIButton *)btn{

    self.commont = self.textView.text;
    
    NSLog(@"%@",self.commont
          );
}



@end