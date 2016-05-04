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

- (UILabel *)zanCount{
    
    if (_zanCount == nil) {
        _zanCount = [[UILabel alloc] init];
        _zanCount.text = @"256";
        [HYMTool initLabel:_zanCount withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _zanCount;
}

- (UIImageView *)zanImage{
    
    if (_zanImage == nil) {
        
        _zanImage = [[UIImageView alloc] init];
    }
    
    return _zanImage;
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
    [self.contentView addSubview:self.zanCount];
    [self.contentView addSubview:self.zanImage];
    
    self.iconImageView.backgroundColor = [UIColor orangeColor];
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,12)
    .widthIs(40).heightIs(40);
    
    
    self.name.sd_layout
    .leftSpaceToView(self.iconImageView,15).topSpaceToView(self.contentView,20).widthIs(80).heightIs(20);
    
    
    self.zanCount.sd_layout
    .rightSpaceToView(self.contentView,15).topSpaceToView(self.contentView,25).heightIs(20).widthIs(30);
    
    self.zanImage.sd_layout
    .rightSpaceToView(self.zanCount,2).heightIs(20).widthIs(30)
    .topEqualToView(self.zanCount);
    
    
    self.comment.sd_layout
    .leftSpaceToView(self.contentView,15).rightSpaceToView(self.contentView,10).heightRatioToView(self.contentView,0.4)
    .topSpaceToView(self.iconImageView,8);
    
}
@end
