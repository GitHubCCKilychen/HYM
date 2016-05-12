//
//  HYMPublishView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishView.h"

@interface HYMPublishView ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *logo;
@property (nonatomic,strong)UIView *topicView;
@property (nonatomic,strong)UIView *brandView;
@end


@implementation HYMPublishView

#pragma mark 懒加载
-(UIImageView *)iconImageView{

    if (_iconImageView == nil) {
        
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{

    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

-(UIButton *)logo{

    if (_logo == nil) {
        
        _logo = [UIButton buttonWithType:UIButtonTypeCustom];
        _logo.layer.cornerRadius = 10;
    }
    return _logo;
}

- (UIView *)topicView{

    if (_topicView == nil) {
        
        _topicView = [[UIView alloc] init];
    }
    return _topicView;
}

- (UIView *)brandView{

    if (_brandView == nil) {
        
        _brandView = [[UIView alloc] init];
    }
    return _brandView;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self initWithView];
        [self initWithBtn];
        
    }
    
    return self;
}

#pragma mark view
- (void)initWithView{

    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.logo];
    [self addSubview:self.topicView];
    
    self.iconImageView.backgroundColor = [UIColor orangeColor];
    self.iconImageView.sd_layout
    .leftSpaceToView(self,10).topSpaceToView(self,10)
    .widthIs(25).heightIs(25);
    
    self.titleLabel.backgroundColor = [UIColor grayColor];
    self.titleLabel.sd_layout
    .leftSpaceToView(self.iconImageView,15).topSpaceToView(self,15)
    .heightIs(20).widthRatioToView(self,0.5);
    
    self.logo.backgroundColor = [UIColor grayColor];
    self.logo.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self.iconImageView,15)
    .widthIs(60).heightIs(60);
}

- (void)initWithBtn{

    NSArray *title = @[@"标题:",@"品牌:"];
    NSArray *textFieldArr = @[@"请输入您标题名称",@"请输入您品牌名称"];
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(90, 50+ (30+i*1)*i, kScreenWitdth*0.65, 30);
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 0.7;
        view.layer.cornerRadius = 3;
        [self addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 5, 40, 20);
        titleLabel.text = title[i];
        [HYMTool initLabel:titleLabel withFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [view addSubview:titleLabel];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(55, 5, view.frame.size.width-60, 20);
        textField.placeholder = textFieldArr[i];
        textField.font = [UIFont systemFontOfSize:14];
        [view addSubview:textField];
        
    }
}
@end
