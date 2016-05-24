//
//  HYMRecordCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMRecordCell.h"

@implementation HYMRecordCell

#pragma mark 懒加载
-(UIImageView *)taskImage{

    if (_taskImage == nil) {
        
        _taskImage = [[UIImageView alloc] init];
        
    }
    
    return _taskImage;
}

- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.text = @"本金x元，期限x天";
        [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        _title.numberOfLines = 0;
    }
    return _title;
}

- (UIButton *)timeBtn{

    if (_timeBtn == nil) {
        
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn.layer.cornerRadius =5;
        [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _timeBtn;
}
#pragma mark 数据
- (void)setModel:(HYMMyBookModel *)model{

    _model = model;
 
    self.title.text = _model.name;
    [self.timeBtn setTitle:_model.regdate forState:UIControlStateNormal];
    [self.taskImage sd_setImageWithURL:[NSURL URLWithString:_model.imgurl0]];
    
    //时间转换
    [HYMTool internalFromCreatTime:_model.regdate formatString:@"hh:mm"];
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithView];
    }
    
    return self;
}

- (void)initWithView{

    
    [self.contentView addSubview:self.taskImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.timeBtn];
    
    
    //图大小60.60
    self.taskImage.backgroundColor = [UIColor grayColor];
    self.taskImage.sd_layout
    .leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10).widthRatioToView(self.contentView,0.25);
    
//    self.title.backgroundColor = [UIColor grayColor];
    self.title.sd_layout
    .leftSpaceToView(self.taskImage,10).topSpaceToView(self.contentView,15)
    .widthRatioToView(self.contentView,0.5).heightIs(40);
 
    self.timeBtn.sd_layout
    .rightSpaceToView(self.contentView,5)
    .heightIs(30).widthIs(50).topSpaceToView(self.contentView,10);
    
}

@end
