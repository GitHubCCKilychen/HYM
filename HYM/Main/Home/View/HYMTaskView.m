//
//  HYMTaskView.m
//  首页
//
//  Created by 刘晓雪 on 16/4/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define brownBackColor [UIColor colorWithRed:252/256.f green:217/256.f blue:53/256.f alpha:1]

#define kViewWidth kScreenWidth-10
#define kViewHeight  self.brownView.frame.size.height

@interface HYMTaskView ()

@property (nonatomic,strong)UIView *brownView;
@property (nonatomic,strong)UILabel *moneyLabel;//收益
@property (nonatomic,strong)UILabel *titleLabel;//累计收益
@property (nonatomic,strong)UIImageView *lineView;
@property (nonatomic,strong)UILabel *invitationLabel;//邀请
@property (nonatomic,strong)UILabel *taskLabel;//任务返利
@end
@implementation HYMTaskView

#pragma mark 懒加载
-(UIView *)brownView{

    if (_brownView == nil) {
        
        _brownView = [[UIView alloc] init];
        _brownView.frame = CGRectMake(5, 85,kScreenWidth-10, 70);
        _brownView.backgroundColor = brownBackColor;
        _brownView.layer.cornerRadius = 5;
        
    }
    
    return _brownView;
}
- (UILabel *)moneyLabel{

    if (_moneyLabel == nil) {
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.frame = CGRectMake(kScreenWidth/2-kScreenWitdth/2, self.brownView.frame.size.height-65, 160, 40);
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.font = [UIFont systemFontOfSize:24];
        _moneyLabel.text = @"+ 5263.25";
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _moneyLabel;
}
- (UILabel *)titleLabel{

    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(kScreenWidth/2-kScreenWitdth/3.5, self.brownView.frame.size.height-40, 60, 40);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"累计收益";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor blackColor];
    }
    
    return _titleLabel;
}

- (UIImageView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIImageView alloc] init];
    }
    return _lineView;
}

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self initWithView];
    }
    
    return self;
}
#pragma mark 中间按钮
- (void)initWithButton{
    
    
    CGFloat  width = kScreenWidth-10;
    CGFloat height = self.brownView.frame.size.height;
    NSArray *titleArr = @[@"任务赚钱",@"邀请奖励",@"我的账本"];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(33+(width/3)*i, 10, 45, 45);
        btn.backgroundColor = [UIColor brownColor];
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [self addSubview:btn];
        
 
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(33+(width/3)*i, 60, 50, 20);
        title.text = [NSString stringWithFormat:@"%@",titleArr[i]];
        title.font = [UIFont systemFontOfSize:12];
        [self addSubview:title];
   
    }
    //任务返利跟邀请返利按钮
    
    NSArray *titleA = @[@"任务返利",@"邀请返利"];
    for (int i = 0; i < 2; i++) {
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(kScreenWidth/9+(kScreenWidth/2)*i, self.titleLabel.frame.size.height+20, kScreenWidth/4, 20);
//        btn.backgroundColor = [UIColor brownColor];
//
//        [self.brownView addSubview:btn];
//        
//        UILabel *title = [[UILabel alloc] init];
//        title.frame = CGRectMake(48+(width/2)*i, self.titleLabel.frame.size.height+40, 80, 20);
//        title.textColor = [UIColor brownColor];
//        title.text = [NSString stringWithFormat:@"%@",titleA[i]];
//        title.textAlignment = NSTextAlignmentCenter;
//        title.font = [UIFont systemFontOfSize:12];
//        [self.brownView addSubview:title];
//        
//        UILabel *redLabel = [[UILabel alloc] init];
//        redLabel.backgroundColor = [UIColor redColor];
//        redLabel.frame = CGRectMake(43+(width/2)*i, self.titleLabel.frame.size.height+42, 15, 15);
//        redLabel.layer.cornerRadius =3;
//        redLabel.layer.masksToBounds = YES;
//        [self.brownView addSubview:redLabel];
        
    }
   
}

#pragma mark 
- (void)initWithView{

    [self initWithButton];
    [self initWithLastView];
   

}

#pragma mark 收益部分
- (void)initWithLastView{

    [self.brownView addSubview:self.moneyLabel];
    [self.brownView addSubview:self.titleLabel];
    [self addSubview:self.brownView];
    
    

    
}

#pragma mark 任务邀请账本事件
- (void)btnAct:(UIButton *)btn{

    switch (btn.tag - 100) {
        case 0:
        {
         NSLog(@"0");
        }
            break;
        case 1:
        {
         NSLog(@"1");
        }
            break;
        case 2:
        {
        
            NSLog(@"2");
        }
            break;
        default:
            break;
    }
    
}

@end
