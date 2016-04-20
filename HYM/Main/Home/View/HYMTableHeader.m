//
//  HYMTableHeader.m
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTableHeader.h"

@interface HYMTableHeader ()


@end
@implementation HYMTableHeader
#pragma mark 懒加载
-(ScrollView *)scrollView{


    if (_scrollView == nil) {
        
        _scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
    }
    
    return _scrollView;
}

-(HYMTaskView *)taskView{

    if (_taskView == nil) {
    
        _taskView = [[HYMTaskView alloc] init];
        _taskView.frame = CGRectMake(0, 150, self.frame.size.width, 160);
   
    }
    
    return _taskView;
}


- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    
        [self initWithView];
    }
    
    return self;
}

- (void)initWithView{


    [self addSubview:self.scrollView];
    [self addSubview:self.taskView];

}


@end
