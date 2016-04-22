//
//  HYMInformationVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInformationVC.h"
#import "HYMInfoTableView.h"
@interface HYMInformationVC ()

@property (nonatomic,strong)HYMInfoTableView *infoTable;
@property (nonatomic,weak)UIView *lineView;

@property (nonatomic,strong)NSArray *counts;
@property (nonatomic,strong)NSArray *count2;
@end

@implementation HYMInformationVC

- (HYMInfoTableView *)infoTable{

    if (_infoTable == nil) {
        
        _infoTable = [[HYMInfoTableView alloc] init];
        _infoTable.frame = CGRectMake(0, 44, kScreenWitdth, kScreenHeight);
    }
    return _infoTable;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self initWithBtn];
    [self initWithView];
   
}


#pragma mark 数据
- (void)loadData{


    
}
#pragma mark 按钮
- (void)initWithBtn{
    
    self.title = @"今日资讯";
    
    NSArray *titleArr = @[@"网贷资讯",@"银行资讯"];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btm = [UIButton buttonWithType:UIButtonTypeCustom];
        btm.frame = CGRectMake(self.view.frame.size.width/2*i, 0, self.view.frame.size.width/2, 40);
        //        btm.frame = CGRectMake(0, 80, 100, 40);
        [btm setTitle:titleArr[i] forState:UIControlStateNormal];
        [btm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btm.titleLabel.textAlignment = NSTextAlignmentCenter;
        btm.tag = 0;
        btm.tag = i;
        [btm addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btm];
        
        
    }
    
    UIView *lineView = [[UIView alloc] init];
    _lineView = lineView;
    lineView.frame = CGRectMake(0, 43, self.view.frame.size.width/2, 1);
    lineView.backgroundColor =[UIColor redColor];
    [self.view addSubview:lineView];
    
    
}

#pragma nark 表格
- (void)initWithView{
    
    
    [self.view addSubview:self.infoTable];
    self.counts = @[@"张三",@"类似",@"网无",@"麻溜",@"lianxi",@"屋里",@"1234"];
    self.count2 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    self.infoTable.count = self.counts;
}

- (void)btnAct:(UIButton *)btn{
    
    
    
    self.infoTable.index = btn.tag;
    
    [UIView animateWithDuration:0.35 animations:^{
        if (btn.tag == 0) {
            
            _lineView.frame = CGRectMake(0, 43, self.view.frame.size.width/2, 1);
            
            self.infoTable.count = self.counts;
        }else if (btn.tag == 1){
            
            
            _lineView.frame = CGRectMake(self.view.frame.size.width/2, 43, self.view.frame.size.width/2, 1);
            self.infoTable.count2 = self.count2;
        }
        
        
    }];
    
    
}





@end
