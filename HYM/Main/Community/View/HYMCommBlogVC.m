//
//  HYMCommBlogVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommBlogVC.h"
#import "HYMTaskBottom.h"
@interface HYMCommBlogVC ()

@property (nonatomic,strong)HYMTaskBottom *bottom;
@property (nonatomic,weak)UITextField *textField;
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
}

- (void)initDefalut{

    self.title = @"帖子详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *report = [UIButton buttonWithType:UIButtonTypeCustom];
    report.frame = CGRectMake(0, 0, 40, 40);
    [report setTitle:@"举报" forState:UIControlStateNormal];
    [report setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [report addTarget:self action:@selector(reportAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:report];
    
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0, 0, 40, 40);
    messageBtn.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar addSubview:messageBtn];
    
    
    UIBarButtonItem *reportItem = [[UIBarButtonItem alloc] initWithCustomView:report];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    
    self.navigationItem.rightBarButtonItems = @[messageItem,reportItem];
    
}

- (void)initWithView{

    [self.view addSubview:self.bottom];
    
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
