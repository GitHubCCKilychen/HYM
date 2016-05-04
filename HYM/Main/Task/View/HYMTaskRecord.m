//
//  HYMTaskRecord.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskRecord.h"
#import "HYMTaskDeailsCell.h"
#import "HYMTaskDeailsTableView.h"
@interface HYMTaskRecord ()


@end
@implementation HYMTaskRecord

#pragma mark 懒加载
- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =  [UIColor orangeColor];
        _lineView.layer.cornerRadius = 4;
    }
    return _lineView;
}

- (UILabel *)taskRecord{

    if (_taskRecord == nil) {
        
        _taskRecord = [[UILabel alloc] init];
        _taskRecord.text = @"任务流程";
        [HYMTool initLabel:_taskRecord withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _taskRecord;
}

- (UIImageView *)imageView{

    if (_imageView == nil) {
        
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)officialContent{

    if (_officialContent == nil) {
        

        _officialContent = [[UILabel alloc] init];
        _officialContent.text = @"点击进入官方网站:";
        [HYMTool initLabel:_officialContent withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _officialContent;
}

- (UILabel *)officialWebsite{

    if (_officialWebsite == nil) {
        
        _officialWebsite = [[UILabel alloc] init];
        _officialWebsite.text = @"https://www.baidu.com";
        [HYMTool initLabel:_officialWebsite withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
        _officialWebsite.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(websiteAct:)];
        [_officialWebsite addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(textLongAct:)];
        [_officialWebsite addGestureRecognizer:longGes];
    }
    return _officialWebsite;
}

- (UILabel *)moreContent{

    if (_moreContent == nil) {
        
        _moreContent = [[UILabel alloc] init];
        _moreContent.text = @"若有多项报单，请直接联系客服";
        [HYMTool initLabel:_moreContent withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _moreContent;
}

- (UILabel *)officeNumber{

    if (_officeNumber == nil) {
        
        _officeNumber = [[UILabel alloc] init];
        _officeNumber.text = @"客服电话:0531-88568221";
        [HYMTool initLabel:_officeNumber withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _officeNumber;
}

- (UIView *)userline{

    if (_userline == nil) {
        
        _userline = [[UIView alloc] init];
        _userline.backgroundColor = [UIColor orangeColor];
        _userline.layer.cornerRadius = 4;
    }
    return _userline;
}

-(UILabel *)userEvaluation{

    if (_userEvaluation == nil) {
        
        _userEvaluation = [[UILabel alloc] init];
        _userEvaluation.text = @"用户介绍";
        [HYMTool initLabel:_userEvaluation withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _userEvaluation;
}

- (UILabel *)zan{

    if (_zan == nil) {
        _zan = [[UILabel alloc] init];
        _zan.text = @"赞26万";
        [HYMTool initLabel:_zan withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor grayColor] withTextAlignment:nil];
    }
    return _zan;
}

-(UIView *)bottomLine{

    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor grayColor];
        _bottomLine.alpha = 0.2;
    }
    return _bottomLine;
}
- (UIView *)sliderView{

    if (_sliderView == nil) {
        
        _sliderView = [[UIView alloc] init];
        _sliderView.frame = CGRectMake(15, 370-12,80, 1);
        _sliderView.backgroundColor = [UIColor orangeColor];
    }
    return _sliderView;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self initWithView];
        [self initWithBtn];
    }
    
    return self;
}

#pragma mark view
- (void)initWithView{

    
    [self addSubview:self.lineView];
    [self addSubview:self.taskRecord];
    [self addSubview:self.imageView];
    [self addSubview:self.officialContent];
    [self addSubview:self.officialWebsite];
    [self addSubview:self.moreContent];
    [self addSubview:self.officeNumber];
    
    [self addSubview:self.userline];
    [self addSubview:self.userEvaluation];
    [self addSubview:self.zan];
    [self addSubview:self.bottomLine];
    [self addSubview:self.sliderView];
    
    self.lineView.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,10)
    .widthIs(8).heightIs(20);
    
//    self.taskRecord.backgroundColor = [UIColor orangeColor];
    self.taskRecord.sd_layout
    .leftSpaceToView(self.lineView,10).topSpaceToView(self,10)
    .widthIs(80).heightIs(20);
    
    

    self.imageView.backgroundColor = [UIColor grayColor];
    self.imageView.sd_layout
    .leftSpaceToView(self,10).rightSpaceToView(self,10)
    .topSpaceToView(self.lineView,10).heightRatioToView(self,0.4);
    
//    self.officialContent.backgroundColor = [UIColor brownColor];
    self.officialContent.sd_layout
    .leftSpaceToView(self,20).topSpaceToView(self.imageView,10)
    .widthRatioToView(self,0.35).heightIs(20);
    
//    self.officialWebsite.backgroundColor = [UIColor grayColor];
    self.officialWebsite.sd_layout
    .leftSpaceToView(self.officialContent,0).topEqualToView(self.officialContent)
    .widthRatioToView(self,0.5).heightIs(20);
    
//    self.moreContent.backgroundColor = [UIColor grayColor];
    self.moreContent.sd_layout
    .leftSpaceToView(self,20).topSpaceToView(self.officialWebsite,5)
    .heightIs(20).widthRatioToView(self,0.6);
    
//    self.officeNumber.backgroundColor =[UIColor brownColor];
    self.officeNumber.sd_layout
    .leftSpaceToView(self,20).topSpaceToView(self.moreContent,5)
    .widthRatioToView(self,0.5).heightIs(20);
    
    
    self.userline.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self.officeNumber,20)
    .heightIs(20).widthIs(8);
    
    self.userEvaluation.sd_layout
    .leftSpaceToView(self.userline,10).topEqualToView(self.userline)
    .heightIs(20).widthIs(80);
    
    self.zan.sd_layout
    .rightSpaceToView(self,10).bottomSpaceToView(self,20)
    .heightIs(20).widthIs(50);
    
    self.bottomLine.sd_layout
    .leftSpaceToView(self,10).bottomSpaceToView(self,10)
    .rightSpaceToView(self,10).heightIs(1);
}

#pragma mark 转发评论
- (void)initWithBtn{
    
    NSString *forward = [NSString stringWithFormat:@"转发4502"];
    NSString *comment = [NSString stringWithFormat:@"评论4万"];
    NSArray *title = @[forward,comment];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i*80, 370-50, 80, 40);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(sliderAct:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:title[i] forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor grayColor];
        [self addSubview:btn];
    }
    
}

#pragma mark 滑动
- (void)sliderAct:(UIButton *)btn{

    HYMTaskDeailsTableView *tableView = [[HYMTaskDeailsTableView alloc] init];
    
    tableView.index = btn.tag;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"index" object:self];
    
    [UIView animateWithDuration:0.35 animations:^{
        
        //此处位置是写死的，后期需要改动
        switch (btn.tag) {
            case 0:
                self.sliderView.frame = CGRectMake(15, 370-12,80, 1);
                
//                NSLog(@"1");
                break;
            case 1:
                self.sliderView.frame = CGRectMake(95, 370-12,80, 1);
//                NSLog(@"2");
                break;
            default:
                break;
        }
    }];
    
}
#pragma mark 点击复制事件
- (void)websiteAct:(UITapGestureRecognizer *)tap{

    if (tap.state == UIGestureRecognizerStateRecognized &&
        [tap.view isKindOfClass:[UILabel class]]) {
        
        UILabel *someLabel = (UILabel *)tap.view;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:someLabel.text];
    }
    
}

#pragma mark 长按复制
- (void)textLongAct:(UILongPressGestureRecognizer *)longGes{

    if (longGes.state == UIGestureRecognizerStateRecognized &&
        [longGes.view isKindOfClass:[UILabel class]])
    {
        UILabel *someLabel = (UILabel *)longGes.view;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:someLabel.text];
        
    }
    
}
@end
