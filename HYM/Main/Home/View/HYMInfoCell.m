//
//  HYMInfoCell.m
//  今日资讯
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInfoCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
@implementation HYMInfoCell
#pragma mark 懒加载
- (UIImageView *)messageImage{

    if (_messageImage == nil) {
        
        _messageImage = [[UIImageView alloc] init];
        _messageImage.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _messageImage;
}

- (UILabel *)time{

    if (_time == nil) {
        
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:13];
        _time.text = @"2015 10-1 10:22";
        _time.textColor = [UIColor grayColor];
    }
    return _time;
}
- (UILabel *)commont{

    if (_commont == nil) {
        _commont = [[UILabel alloc] init];
        _commont.text = @"111111评论";
        _commont.textColor = [UIColor grayColor];
        _commont.font = [UIFont systemFontOfSize:12];
        
    }
    return _commont;
}

- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.numberOfLines = 0;
        _title.text = @"223564763478569809876765765677867t7u9y850683045";
        _title.font = [UIFont systemFontOfSize:13];
        
    }
    return _title;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithView];
    }
    
    return self;
}

#pragma mark 控件
- (void)initWithView{

    self.messageImage.backgroundColor = [UIColor grayColor];
//    self.title.backgroundColor = [UIColor greenColor];
    
    [self.contentView addSubview:self.messageImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.commont];
    [self.contentView addSubview:self.time];
    
    //左10上15
    self.messageImage.sd_layout
    .leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,15).widthRatioToView(self.contentView,0.3);
    
    self.title.sd_layout
    .leftSpaceToView(self.messageImage,10)
    .topEqualToView(self.messageImage)
    .rightSpaceToView(self.contentView,10)
    .heightIs(40);// 此处还需要修改
    
//    self.commont.backgroundColor = [UIColor grayColor];
    self.commont.sd_layout
    .leftEqualToView(self.title)
    .bottomSpaceToView(self.contentView,10)
    .topSpaceToView(self.title,10)
    .heightIs(20)
    .widthIs(50);
  
    
    self.time.sd_layout
    .leftSpaceToView(self.commont,0)
    .topEqualToView(self.commont)
    .bottomEqualToView(self.commont)
    .rightSpaceToView(self.contentView,20);
    
}

- (void)setModel:(HYMTodayInfoModel *)model{

    _model = model;
    
    
    self.title.text = _model.name;
    
    
    //图片加载
    [self.messageImage sd_setImageWithURL:[NSURL URLWithString:_model.imgurl0]];

    //此处做判断
    
    
    self.time.text = _model.regdate;
    self.commont.text = [NSString stringWithFormat:@"%d",_model.totalCount];
}
@end
