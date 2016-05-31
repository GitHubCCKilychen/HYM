//
//  HYMListCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMListCell.h"
#define checkStringNull(Str) (Str) == [NSNull null] || (Str) == nil ? @”” : [NSString stringWithFormat:@”%@”, (Str)]
@implementation HYMListCell

-(UIImageView *)storeImage{
    
    if (_storeImage == nil) {
        _storeImage = [[UIImageView alloc] init];

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

#pragma mark 数据
- (void)setModel:(HYMTaskRecordModel *)model{

    _model = model;
    
    
    if ([_model.logo isEqual:[NSNull null]] ||(_model.logo) == nil ? @"":[NSString stringWithFormat:@"%@",(_model.logo)]) {
        
        self.storeImage.image = [UIImage imageNamed:@"aaa"];
    }else{
        
        
        [self.storeImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    }
    
    
    //报错
    if ([_model.audit_time isEqual:[NSNull null]] ||(_model.audit_time) == nil ? @"":[NSString stringWithFormat:@"%@",(_model.audit_time)]) {
        
    
        self.timeEnd.text = [NSString stringWithFormat:@"%@",[_model valueForKey:@"audit_time"]];
        //contentnull
        
        
    }
    
    if ([_model.content isEqual:[NSNull null]]) {
        
        self.title.text = @"23423";
    }else{
    
        self.title.text = _model.content;
    }


}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initCell1];
    }
    return self;
}
- (void)initCell1{
    [self.contentView addSubview:self.storeImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.timeImage];
    [self.contentView addSubview:self.timeEnd];
    [self.contentView addSubview:self.peopleCount];
    [self.contentView addSubview:self.peopleImage];
    
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
    
    
}
@end
