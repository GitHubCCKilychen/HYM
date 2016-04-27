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
        
        _scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth,self.frame.size.height*0.4)];
    }
    
    return _scrollView;
}

-(HYMTaskView *)taskView{

    if (_taskView == nil) {
    
        _taskView = [[HYMTaskView alloc] init];
//        _taskView.frame = CGRectMake(0, 100, self.frame.size.width, self.frame.size.height*0.6);
   
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
    //
    self.taskView.sd_layout
    .leftSpaceToView(self,0).topSpaceToView(self.scrollView,0)
    .bottomSpaceToView(self,10).rightSpaceToView(self,0);
//    //这里适配后4就有问题

}


@end
