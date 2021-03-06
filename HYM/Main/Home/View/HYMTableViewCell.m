  //
//  HYMTableViewCell.m
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTableViewCell.h"
#define kTopWidth kScreenWitdth-30-(kScreenWitdth/2-kScreenWitdth/6)
//#import "RealityDetailVC.h"
#import "CategoryVC.h"
#import "PostPublishNewVC.h"
@implementation HYMTableViewCell


#pragma mark 数据
- (void)setModel:(HYMInfoCellModel *)model{

    _model = model;
    
    //cell3
    self.titleInforation.text = _model.name;
    self.time.text = _model.regdate;
   
    //给一张默认图片，先使用默认图片，当图片加载完成后再替换
    //[self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"]];
    //图片加载
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgurl0]];
    
    //评论参数未添加
    NSString *string = [NSString stringWithFormat:@"%@ 阅读",_model.replycount];
    self.comment.text = string;
    
}

#pragma mark 任务数据
- (void)setTaskModel:(HYMTaskModel *)taskModel{

    _taskModel = taskModel;
    
    NSString *title = [NSString stringWithFormat:@"%@",_taskModel.title];
    self.title.text = title;
    
    
    [self.storeImage sd_setImageWithURL:[NSURL URLWithString:_taskModel.logo]];
    
    NSString *endTime = [NSString stringWithFormat:@"截止时间:%@",_taskModel.end_time];
    self.timeEnd.text = endTime;
    NSString *peopleCount = [NSString stringWithFormat:@"参与人数:%@",_taskModel.join_number];
    self.peopleCount.text = peopleCount;
    
    
}

- (void)setMallModel:(HYMCenMallModel *)mallModel{

    _mallModel = mallModel;
}
- (NSArray *)btnTitleArr{

    if (_btnTitleArr == nil) {
        
        _btnTitleArr = [NSArray array];
        _btnTitleArr = @[@"未参与",@"未报单",@"未审核"];
    }
    return _btnTitleArr;
}
#pragma mark 未参与颜色值

#pragma mark cell1
-(UIImageView *)storeImage{
    
    if (_storeImage == nil) {
        _storeImage = [[UIImageView alloc] init];
        _storeImage.backgroundColor = [UIColor grayColor];
        
    }
    
    return _storeImage;
}

-(UILabel *)title{
    
    if (_title ==nil) {
        _title = [[UILabel alloc] init];
        [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:12] withTextColor:nil withTextAlignment:NSTextAlignmentLeft];
        _title.numberOfLines = 0;
        
    }
    
    return _title;
}

-(UIImageView *)timeImage{
    
    if (_timeImage == nil) {
        _timeImage = [[UIImageView alloc] init];
        _timeImage.image = [UIImage imageNamed:@"截止时间"];
        _timeImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _timeImage;
}

//参与人数
- (UILabel *)peopleCount{

    if (_peopleCount == nil) {
        
        _peopleCount = [[UILabel alloc] init];
        [HYMTool initLabel:_peopleCount withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _peopleCount;
    
}
- (UILabel *)timeEnd{

    if (_timeEnd == nil) {
        
        _timeEnd = [[UILabel alloc] init];
        [HYMTool initLabel:_timeEnd withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _timeEnd;
}

- (UIImageView *)peopleImage{

    if (_peopleImage == nil) {
        
        _peopleImage = [[UIImageView alloc] init];
        _peopleImage.image = [UIImage imageNamed:@"任务图片"];
        _peopleImage.contentMode = UIViewContentModeScaleAspectFit;

    }
    return _peopleImage;
}

//忽略
- (UIButton *)ignoreBtn{

    if (_ignoreBtn == nil) {
        
        _ignoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ignoreBtn.backgroundColor = [UIColor lightGrayColor];
        [_ignoreBtn setTitle:@"忽略" forState:UIControlStateNormal];
        _ignoreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_ignoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _ignoreBtn.layer.cornerRadius = 2;
        [_ignoreBtn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        _ignoreBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _ignoreBtn;
}

//未参与
- (UIButton *)notInvolved{

    if (_notInvolved == nil) {
        _notInvolved = [UIButton buttonWithType:UIButtonTypeCustom];
        _notInvolved.backgroundColor = [UIColor redColor];
        [_notInvolved setTitle:@"未参与" forState:UIControlStateNormal];
        [_notInvolved setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _notInvolved.layer.cornerRadius = 5;
        _notInvolved.titleLabel.font = [UIFont systemFontOfSize:12];
        _notInvolved.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _notInvolved;
}
#pragma mark 懒加载cell2
- (UIButton *)leftBtn{

    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = [UIColor grayColor];
        
        [_leftBtn addTarget:self action:@selector(leftBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}

- (UIButton *)topBtn{

    if (_topBtn == nil) {
        
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.backgroundColor =[UIColor brownColor];
        [_topBtn addTarget:self action:@selector(topBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _topBtn;

}

-(UIButton *)rightBtn{

    if (_rightBtn == nil) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor brownColor];
    }
    return _rightBtn;
}
- (UIButton *)centerBtn{

    if (_centerBtn == nil) {
        
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.backgroundColor = [UIColor greenColor];
    }
    
    return _centerBtn;
}

#pragma mark cell3

-(UIImageView *)leftImageView{

    if (_leftImageView == nil) {
        
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

-(UILabel *)titleInforation{

    if (_titleInforation == nil) {
        _titleInforation = [[UILabel alloc] init];
        [HYMTool initLabel:_titleInforation withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        _titleInforation.numberOfLines = 0;
    }
    return _titleInforation;
}


- (UILabel *)time{

    if (_time == nil) {
        
        _time = [[UILabel alloc] init];
        _time.layer.borderColor = [UIColor redColor].CGColor;
        _time.textColor = [UIColor grayColor];
        _time.text = @"2016:10:12222";
        _time.font = [UIFont systemFontOfSize:13];
        _time.textAlignment = NSTextAlignmentLeft;
        
        
    }
    
    return _time;
}

-(UILabel *)comment{

    if (_comment == nil) {
        
        _comment = [[UILabel alloc] init];
        _comment.text = @"11900评论";
//        _comment.backgroundColor = [UIColor greenColor];
        _comment.font = [UIFont systemFontOfSize:10];
        _comment.textColor = [UIColor grayColor];
    }
    
    return _comment;
}


#pragma mark cell
- (void)initCell1{
    [self.contentView addSubview:self.storeImage];
    [self.contentView addSubview:self.title];
//    [self.contentView addSubview:self.hotBtn];
    [self.contentView addSubview:self.timeImage];
    [self.contentView addSubview:self.timeEnd];
    [self.contentView addSubview:self.peopleCount];
    [self.contentView addSubview:self.peopleImage];
    [self.contentView addSubview:self.ignoreBtn];
    [self.contentView addSubview:self.notInvolved];
    
    
    self.storeImage.sd_layout
    .leftSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15).widthRatioToView(self.contentView,0.2);

    self.title.sd_layout
    .leftSpaceToView(self.storeImage,5).topSpaceToView(self.contentView,10)
    .widthRatioToView(self.contentView,0.6).heightIs(50);

    
    self.timeImage.sd_layout
    .leftEqualToView(self.title).topSpaceToView(self.title,15)
    .heightIs(15).widthIs(15);
//    self.timeEnd.backgroundColor = [UIColor g];
    self.timeEnd.sd_layout
    .leftSpaceToView(self.timeImage,2).topSpaceToView(self.title,12)
    .widthRatioToView(self.contentView,0.38).heightIs(20);
    
    self.peopleImage.sd_layout
    .leftSpaceToView(self.timeEnd,5)
    .heightIs(15).widthIs(15).topEqualToView(self.timeImage);
    
    self.peopleCount.sd_layout
    .leftSpaceToView(self.peopleImage,0).bottomEqualToView(self.timeEnd)
    .rightSpaceToView(self.contentView,5).topEqualToView(self.timeEnd);
    

    self.ignoreBtn.sd_layout
    .rightSpaceToView(self.contentView,18).topSpaceToView(self.contentView,15)
    .widthIs(33).heightIs(16);
    
    self.notInvolved.sd_layout
    .rightSpaceToView(self.contentView,10).topSpaceToView(self.ignoreBtn,3)
    .widthIs(40).heightIs(19);
    

}

- (void)initCell2{

    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.topBtn];
    [self.contentView addSubview:self.centerBtn];
    [self.contentView addSubview:self.rightBtn];

    self.leftBtn.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,15)
    .widthRatioToView(self.contentView,0.4)
    .heightRatioToView(self.contentView,0.8);
    
    self.topBtn.sd_layout
    .topEqualToView(self.leftBtn)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.leftBtn,1)
    .heightIs(59);
    
    self.centerBtn.sd_layout
    .leftEqualToView(self.topBtn)
    .bottomEqualToView(self.leftBtn)
    .topSpaceToView(self.topBtn,1)
    .heightIs(59)
    .widthRatioToView(self.topBtn,0.5);
    
    self.rightBtn.sd_layout
    .topEqualToView(self.centerBtn)
    .leftSpaceToView(self.centerBtn,1)
    .bottomEqualToView(self.centerBtn)
    .rightEqualToView(self.topBtn);
    
}


- (void)initCell3{

    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleInforation];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.comment];
    
    
    self.leftImageView.sd_layout
    .leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,15).widthRatioToView(self.contentView,0.3);
    
//    self.titleInforation.backgroundColor =[UIColor grayColor];
    self.titleInforation.sd_layout
    .leftSpaceToView(self.leftImageView,5).topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,15).widthRatioToView(self.contentView,0.6)
    .heightRatioToView(self.leftImageView,0.5);
    
    self.comment.sd_layout
    .leftEqualToView(self.titleInforation).topSpaceToView(self.titleInforation,15)
    .bottomEqualToView(self.leftImageView).widthRatioToView(self.leftImageView,0.6);
    
    self.time.sd_layout
    .leftSpaceToView(self.comment,0).topEqualToView(self.comment)
    .bottomEqualToView(self.comment).rightSpaceToView(self.contentView,1);
    
}


#pragma mark cell2点击事件
- (void)leftBtnAct:(UIButton *)btn{
    
    
    CategoryVC *cateVC = [[CategoryVC alloc] init];
    cateVC.keyid = @"无";
    cateVC.keytype = @"7";
    cateVC.typeName = @"全部";
    [self.viewController.navigationController pushViewController:cateVC animated:YES];
    
}

- (void)topBtnAct:(UIButton *)btn{

    NSLog(@"34534");
}

- (void)centerBtnAct:(UIButton *)btn{

}

- (void)rightBtnAct:(UIButton *)btn{

    
}

- (void)setIndex:(NSInteger)index{

    _index= index;
    NSLog(@"%ld",(long)_indexPath);
}
#pragma mark 忽略
- (void)btnAct:(UIButton *)btn{

    NSString *idString = [NSString stringWithFormat:@"%ld",(long)self.index];
    NSDictionary *dic = @{@"keytype":@"1",@"id":@"12",@"token":@"1"};
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v300/task_ignore" target:self selector:@selector(infoData:) parameter:infoDic];
}

- (void)infoData:(NSDictionary *)dic{

    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
}

#pragma mark 
- (void)btnActss:(UIButton *)btn{

    
    PostPublishNewVC *model = [[PostPublishNewVC alloc] init];
    [self.viewController.navigationController pushViewController:model animated:YES];
}
@end
