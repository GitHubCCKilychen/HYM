//
//  HYMFreezeVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFreezeVC.h"
#import "HYMFreezeView.h"
#import "HYMFreeTable.h"
@interface HYMFreezeVC ()

@property (nonatomic,strong)HYMFreezeView *freeView;
@property (nonatomic,strong)HYMFreeTable *freeTable;
@end

@implementation HYMFreezeVC


- (HYMFreezeView *)freeView{

    if (_freeView == nil) {
        
        _freeView = [[HYMFreezeView alloc] initWithFrame:CGRectMake(0, 64, kScreenWitdth, 175)];
    }
    return _freeView;
}
- (HYMFreeTable *)freeTable{
    
    if (_freeTable == nil) {
        
        _freeTable = [[HYMFreeTable alloc] initWithFrame:CGRectMake(0,240 , kScreenWitdth, kScreenHeight-240)];
    }
    return _freeTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self initDefault];
    [self initView];
}

#pragma mark 数据
- (void)loadData{
    
    
    //--没有数据
    NSDictionary *dic = @{@"page":@"1",@"token":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/task/task_froze" target:self selector:@selector(loadData:) parameter:nsdic];
}


#pragma mark 数据解析
- (void)loadData:(NSDictionary *)dic{
    
    NSLog(@"%@",dic);
    
}

- (void)initDefault{

    self.title = @"冻结推单备付金额";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)initView{

    [self.view addSubview:self.freeView];
    [self.view addSubview:self.freeTable];
}

@end
