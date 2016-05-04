//
//  HYMPublishBottomView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishBottomView.h"
#import "HYMPayMoneyVC.h"
@interface HYMPublishBottomView ()

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UIButton *nextBtn;

@end
@implementation HYMPublishBottomView

#pragma mark 懒加载
-(UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor orangeColor];
    }
    return _lineView;
}

-(UILabel *)titleLabel{

    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"报单必填";
        [HYMTool initLabel:_titleLabel withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UIView *)centerView{

    if (_centerView == nil) {
        
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
    }
    return _centerView;
}

-(UIButton *)nextBtn{

    if (_nextBtn == nil) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _nextBtn.layer.cornerRadius = 5;
        [_nextBtn addTarget:self action:@selector(nextBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.backgroundColor = [UIColor orangeColor];
    }
    return _nextBtn;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self initWithView];
        [self initWithBtn];
    }
    
    return self;
}

- (void)initWithView{

    [self  addSubview:self.lineView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.centerView];
    [self addSubview:self.nextBtn];
    
    
    self.lineView.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,10)
    .widthIs(8).heightIs(20);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.lineView,10).topSpaceToView(self,10)
    .widthIs(80).heightIs(20);
    
    self.centerView.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self.titleLabel,10)
    .rightSpaceToView(self,15).heightIs(60);
    
    self.nextBtn.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,15)
    .topSpaceToView(self.centerView,15).bottomSpaceToView(self,5);
    
}

- (void)initWithBtn{

    NSArray *title = @[@"姓名     ",@"截图示范",@"联系电话",@"微信账号"];
    
    
    int margin = 25;
    int x = 20;
    int y = 5;
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30+(i%2*100)+(i%2*margin), y+(i/2*15)+(i/2*15), 100, 20);
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [btn layoutIfNeeded];
        [btn setImage:[UIImage imageNamed:@"ic_arrow_up"] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addSubview:btn];
    }
    
}

#pragma mark 报单必备
- (void)selectBtn:(UIButton *)btn{

    
    switch (btn.tag) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
            NSLog(@"3");
            break;
        default:
            break;
    }
}
#pragma mark  下一步
- (void)nextBtnAct:(UIButton *)nextBtn{

    //判断上面填写的是否都填写完整
    //1.logo 标题 品牌 cell内容 报单必填
    
    HYMPayMoneyVC *payMoney = [[HYMPayMoneyVC alloc] init];
    [self.viewController.navigationController pushViewController:payMoney animated:YES];
}
@end
