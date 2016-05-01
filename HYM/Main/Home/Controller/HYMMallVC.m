//
//  HYMMallVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMallVC.h"
#import "ScrollView.h"
@interface HYMMallVC ()

@property (nonatomic,strong)ScrollView *scrollView;
@end

@implementation HYMMallVC

#pragma mark 懒加载
-(ScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWitdth, 150)];
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    
    return _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    [self initWithView];
    
}

#pragma mark 初始化
- (void)initWithView{

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"薅羊毛工具商城";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    //轮播图
    [self.view addSubview:self.scrollView];
    
}

@end
