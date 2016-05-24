//
//  HYMTaskDeailsCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskDeailsCell.h"

@implementation HYMTaskDeailsCell

#pragma mark 懒加载cell
- (UIImageView *)iconImageView{
    
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 20;
    }
    return _iconImageView;
}

- (UILabel *)name{
    
    if (_name == nil) {
        
        _name = [[UILabel alloc] init];
        _name.text = @"tom";
        [HYMTool initLabel:_name withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _name;
}

- (UILabel *)time{

    if (_time == nil) {
        
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:13];
        _time.textColor = [UIColor lightGrayColor];
        _time.text = @"10分钟之前";
    }
    return _time;
}


- (UILabel *)comment{
    
    if (_comment == nil) {
        
        _comment = [[UILabel alloc] init];
        _comment.text = @"数据1数据2 数据3数据3453入数据数据数据数据数据";
        _comment.numberOfLines = 0;
        [HYMTool initLabel:_comment withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _comment;
}



#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self initWithView];
        [self reloadInputViews];
    }
    return self;
}

#pragma mark view
- (void)initWithView{

    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.comment];
    [self.contentView addSubview:self.time];

    
    self.iconImageView.backgroundColor = [UIColor orangeColor];
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,10)
    .widthIs(40).heightIs(40);
    
    
    self.name.sd_layout
    .leftSpaceToView(self.iconImageView,15).topSpaceToView(self.contentView,10).widthIs(80).heightIs(20);
    
    self.time.sd_layout
    .leftSpaceToView(self.iconImageView,5).topSpaceToView(self.name,5)
    .widthIs(kScreenWitdth/4).heightIs(20);
    

    self.comment.sd_layout
    .leftSpaceToView(self.contentView,15).rightSpaceToView(self.contentView,10).heightRatioToView(self.contentView,0.4)
    .topSpaceToView(self.iconImageView,8);

    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn  =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWitdth-110+i*30+i*3, 15, 30, 20);
        btn.backgroundColor = [UIColor greenColor];
        [self addSubview:btn];
    }
    
    
}
@end
