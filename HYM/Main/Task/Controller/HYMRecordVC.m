//
//  HYMRecordVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMRecordVC.h"
#import "HYMRecordTableView.h"
@interface HYMRecordVC ()

@property (nonatomic,strong)HYMRecordTableView *record;
@end

@implementation HYMRecordVC

#pragma mark 懒加载
- (HYMRecordTableView *)record{

    if (_record == nil) {
        
        _record = [[HYMRecordTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 325)];
       
    }
    return _record;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initWithDefault];
    
    [self initWithView];
}


- (void)loadData{
    
    
    //--没有数据
    NSDictionary *dic = @{@"page":@"1",@"token":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/task/deposit_info" target:self selector:@selector(loadData:) parameter:nsdic];
}


#pragma mark 数据解析
- (void)loadData:(NSDictionary *)dic{
    
    //NSLog(@"%@",dic);
    
}
- (void)initWithDefault{

    self.title = @"任务纪录";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark view
- (void)initWithView{

    [self.view addSubview:self.record];
}

@end
