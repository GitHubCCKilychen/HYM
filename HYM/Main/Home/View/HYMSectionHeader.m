//
//  HYMSectionHeader.m
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSectionHeader.h"
#import "HYMInformationVC.h"
@interface HYMSectionHeader ()

@property (nonatomic,strong)UILabel *morelabel;//更多
@end
@implementation HYMSectionHeader


#pragma mark 懒加载
- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(20,self.frame.size.height/2+5, 60, 20);
        _title.font = [UIFont systemFontOfSize:15];
    }
    
    return _title;
}

-(UILabel *)morelabel{

    if (_morelabel == nil) {
        
        _morelabel = [[UILabel alloc] init];
        _morelabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 65,self.frame.size.height/2+5, 40, 20);
        _morelabel.textAlignment = NSTextAlignmentCenter;
        _morelabel.font = [UIFont systemFontOfSize:12];
        _morelabel.text = @"更多";
    }
    return _morelabel;
}
- (UIImageView *)imageView{

    if (_imageView == nil) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30,self.frame.size.height/2+5, 20, 20);
        _imageView.backgroundColor = [UIColor brownColor];
    }
    
    return _imageView;
}

#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        
        [self initWithView];
    }
    
    return self;
}

#pragma mark  头视图标题
- (void)setSection:(NSInteger)section{

    _section = section;
    
        if (_section == 0) {_title.text = @"任务";}
        else if (_section == 1) {_title.text = @"羊毛商城";}
        else {_title.text = @"今日资讯";}
    
   
}

- (void)initWithView{

    [self addSubview:self.title];
    [self addSubview:self.imageView];
    [self addSubview:self.morelabel];
  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct)];
    [self addGestureRecognizer:tap];
}

#pragma mark 头视图手势事件
- (void)tapAct{

    if (_index == 0) {
       
        //今日资讯
        HYMInformationVC *infoVC = [[HYMInformationVC alloc] init];
        [self.viewController.navigationController pushViewController:infoVC animated:YES];
        
    }else if (_index == 1){
    
        NSLog(@"--1");
    }else{
    
        NSLog(@"--2");
    }
}

- (void)setIndex:(NSInteger)index{

    _index = index;

}
@end
