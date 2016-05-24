//
//  HYMTask2Deatail.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTask2Deatail.h"

@implementation HYMTask2Deatail

#pragma mark 懒加载
-(UIView *)lineView{
    
    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.layer.cornerRadius = 4;
        
    }
    return _lineView;
}

-(UILabel *)activity{
    
    if (_activity == nil) {
        
        _activity = [[UILabel alloc] init];
        _activity.text= @"活动简介";
        [HYMTool initLabel:_activity withFont:[UIFont boldSystemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
        [_activityContent sizeToFit];
    }
    return _activity;
}

- (UILabel *)activityContent{
    
    if (_activityContent == nil) {
        
        _activityContent = [[UILabel alloc] init];
        _activityContent.numberOfLines = 0;
        _activityContent.text = @"通过活动链接注册完成认证及投资，投资100元（充值90元，勾选10元红包）新手15天收益10元";
        [HYMTool initLabel:_activityContent withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _activityContent;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}



- (void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
    
    if (_indexPath.row < 2) {
        
        [self addSubview:self.lineView];
        [self addSubview:self.activity];
        [self addSubview:self.activityContent];
        //左侧15上册10
        self.lineView.backgroundColor = [UIColor orangeColor];
        self.lineView.sd_layout
        .leftSpaceToView(self,15).topSpaceToView(self,10)
        .widthIs(8).heightIs(20);
        
        self.activity.sd_layout
        .topEqualToView(self.lineView).leftSpaceToView(self.lineView,10)
        .widthIs(80).heightIs(20);
        
        self.activityContent.sd_layout
        .leftSpaceToView(self,15).rightSpaceToView(self,10)
        .topSpaceToView(self.activity,10).heightIs(40);
    }
    
    if (_indexPath.row == 1) {
        
        self.activity.text = @"任务教程";
        self.activityContent.text = @"通过活动链接注册完成认证及投资，投资100元（充值90元，勾选10元红包）新手15天收益10元";
    }
        
}

- (void)initWithBtn{
    
  
}
@end
