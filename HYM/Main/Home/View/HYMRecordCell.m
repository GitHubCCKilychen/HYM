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
        [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _title;
}

- (UILabel *)subTitle{

    if (_subTitle == nil) {
        
        _subTitle = [[UILabel alloc] init];
        _subTitle.text = @"投资收益x元，约赎回x元";
        [HYMTool initLabel:_subTitle withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _subTitle;
}

- (UIButton *)timeBtn{

    if (_timeBtn == nil) {
        
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn.layer.cornerRadius =5;
    }
    return _timeBtn;
}
- (void)awakeFromNib {
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithView];
    }
    
    return self;
}

- (void)initWithView{

    
    [self.contentView addSubview:self.taskImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.subTitle];
    [self.contentView addSubview:self.timeBtn];
    
    
    //图大小60.60
    self.taskImage.backgroundColor = [UIColor grayColor];
    self.taskImage.sd_layout
    .leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10).widthRatioToView(self.contentView,0.25);
    
//    self.title.backgroundColor = [UIColor grayColor];
    self.title.sd_layout
    .leftSpaceToView(self.taskImage,10).topSpaceToView(self.contentView,15)
    .widthRatioToView(self.contentView,0.4).heightIs(20);
    
//    self.subTitle.backgroundColor = [UIColor brownColor];
    self.subTitle.sd_layout
    .leftEqualToView(self.title).bottomSpaceToView(self.contentView,20)
    .widthRatioToView(self.contentView,0.6).heightIs(20);
    
    self.timeBtn.backgroundColor = [UIColor blueColor];
    self.timeBtn.sd_layout
    .leftSpaceToView(self.title,15).rightSpaceToView(self.contentView,10)
    .heightIs(30).widthIs(50).topSpaceToView(self.contentView,10);
    
}

@end
