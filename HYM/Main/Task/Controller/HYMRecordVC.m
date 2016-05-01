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
    
    [self initWithDefault];
    
    [self initWithView];
}

- (void)initWithDefault{

    self.title = @"任务纪录";
}

#pragma mark view
- (void)initWithView{

    [self.view addSubview:self.record];
}

@end
