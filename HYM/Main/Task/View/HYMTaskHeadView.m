//
//  HYMTaskHeadView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskHeadView.h"
#import "HYMTaskRecordView.h"
#import "HYMActivityView.h"
#import "HYMTaskRecord.h"
@interface HYMTaskHeadView ()

@property (nonatomic,strong)HYMTaskRecordView *taskView;
@property (nonatomic,strong)HYMActivityView *activityView;
@property (nonatomic,strong)HYMTaskRecord *recordView;

@end

@implementation HYMTaskHeadView

#pragma mark 懒加载

-(HYMTaskRecord *)recordView{

    if (_recordView == nil) {
        
        _recordView = [[HYMTaskRecord alloc] init];
        
        _recordView.frame = CGRectMake(0, 430, kScreenWitdth, 370);
    }
    return _recordView;
}
- (HYMTaskRecordView *)taskView{

    if (_taskView == nil) {
        
        _taskView = [[HYMTaskRecordView alloc] init];
        _taskView.frame = CGRectMake(0, 0, kScreenWitdth, 100);
    }
    
    return _taskView;
}
- (HYMActivityView *)activityView{

    if (_activityView == nil) {
        
        _activityView = [[HYMActivityView alloc] init];
        _activityView.frame = CGRectMake(0, 120, kScreenWitdth, 300);
    }
    
    return _activityView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        
        [self initView];
    }
    
    return self;
}

- (void)initView{

    
    [self addSubview:self.taskView];
    [self addSubview:self.activityView];
    [self addSubview:self.recordView];
}
@end