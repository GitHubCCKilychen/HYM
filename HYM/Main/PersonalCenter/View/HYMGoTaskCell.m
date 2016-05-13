//
//  HYMGoTaskCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMGoTaskCell.h"

@implementation HYMGoTaskCell

#pragma mark 懒加载

- (void)setSelection:(NSInteger)selection{
    
    _selection = selection;
   
    if (self.indexPath.row == 2) {
        
        [self initWithBtn:self.selection];
    }
    
}
- (NSArray *)btnTitleStop{

    if (_btnTitleStop == nil) {
        
        _btnTitleStop = [NSArray array];
        _btnTitleStop = @[@"重新发布",@"下架"];
    }
    return _btnTitleStop;
}

- (NSArray *)btnTitle{

    if (_btnTitle == nil) {
        
        _btnTitle = [NSArray array];
        _btnTitle = @[@"下架",@"暂停"];
    }
    return _btnTitle;
}
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
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return  self;
}


- (void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
    
    if (_indexPath.row == 2) {
        
      
    }else{
    
        [self initView];
    }
}

- (void)initView{

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

- (void)initWithBtn:(NSInteger)selection{
    
    
    CGFloat btnWidth = (kScreenWitdth - 3*15)/2;
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i*btnWidth+i*15, 12.5,btnWidth, 40);
        btn.backgroundColor = [UIColor orangeColor];
        btn.layer.cornerRadius = 5;
        
        if (self.selection == 0) {
            
            [btn setTitle:self.btnTitle[i] forState:UIControlStateNormal];
        }else if (self.selection == 1){
            
            [btn setTitle:self.btnTitleStop[i] forState:UIControlStateNormal];
        }
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:btn];
        
        
    }
    
}
@end
