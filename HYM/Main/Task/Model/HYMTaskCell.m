//
//  HYMTaskCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskCell.h"

@implementation HYMTaskCell

#pragma mark 懒加载

#pragma mark cell1
-(UIImageView *)moneyImage{

    if (_moneyImage == nil) {
        
        _moneyImage = [[UIImageView alloc] init];
    }
    return _moneyImage;
}
-(UILabel *)cellOneTitle{

    if (_cellOneTitle == nil) {
        
        _cellOneTitle = [[UILabel alloc] init];
    }
    return _cellOneTitle;
}

#pragma mark cell2
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
- (UIButton *)hotBtn{
    
    if (_hotBtn == nil) {
        
        _hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hotBtn.backgroundColor = [UIColor redColor];
        [_hotBtn setTitle:@"热" forState:UIControlStateNormal];
        [_hotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _hotBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _hotBtn.layer.cornerRadius = 2;
        _hotBtn.layer.masksToBounds = YES;
        _hotBtn.backgroundColor = [UIColor redColor];
        
    }
    return _hotBtn;
}
-(UIImageView *)timeImage{
    
    if (_timeImage == nil) {
        _timeImage = [[UIImageView alloc] init];
        _timeImage.backgroundColor = [UIColor grayColor];
    }
    
    return _timeImage;
}

//参与人数
- (UILabel *)peopleCount{
    
    if (_peopleCount == nil) {
        
        _peopleCount = [[UILabel alloc] init];
        [HYMTool initLabel:_peopleCount withFont:[UIFont systemFontOfSize:10] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _peopleCount;
    
}
- (UILabel *)timeEnd{
    
    if (_timeEnd == nil) {
        
        _timeEnd = [[UILabel alloc] init];
        [HYMTool initLabel:_timeEnd withFont:[UIFont systemFontOfSize:11] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _timeEnd;
}

- (UIImageView *)peopleImage{
    
    if (_peopleImage == nil) {
        
        _peopleImage = [[UIImageView alloc] init];
        _peopleImage.backgroundColor = [UIColor redColor];
    }
    return _peopleImage;
}

//忽略
- (UIButton *)ignoreBtn{
    
    if (_ignoreBtn == nil) {
        
        _ignoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ignoreBtn.backgroundColor = [UIColor lightGrayColor];
        [_ignoreBtn setTitle:@"忽略" forState:UIControlStateNormal];
        _ignoreBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_ignoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _ignoreBtn.layer.cornerRadius = 2;
        _ignoreBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _ignoreBtn;
}
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    
    return  self;
}

#pragma mark 数据
- (void)setModel:(HYMTaskModel *)model{

    _model = model;

    [self.storeImage sd_setImageWithURL:[NSURL URLWithString:_model.logo]];
    
    NSString *title = [NSString stringWithFormat:@"%@",_model.title];
    self.title.text = title;
    
    NSString *endTime = [NSString stringWithFormat:@"截止时间:%@",_model.end_time];
    self.timeEnd.text = endTime;
    NSString *peopleCount = [NSString stringWithFormat:@"参与人数:%@",_model.join_number];
    self.peopleCount.text = peopleCount;
}

#pragma mark cell1
- (void)cell1{

    [self.contentView addSubview:self.moneyImage];
    [self.contentView addSubview:self.cellOneTitle];
    
    self.moneyImage.backgroundColor = [UIColor grayColor];
    self.moneyImage.sd_layout
    .leftSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).widthIs(20);
    self.cellOneTitle.backgroundColor = [UIColor brownColor];
    self.cellOneTitle.sd_layout
    .leftSpaceToView(self.moneyImage,10).topEqualToView(self.moneyImage)
    .bottomEqualToView(self.moneyImage).widthRatioToView(self.contentView,0.7);
    
}

#pragma mark  cell2
- (void)cell2{
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
    
    //    self.title.backgroundColor = [UIColor grayColor];
    self.title.sd_layout
    .leftSpaceToView(self.storeImage,5).topEqualToView(self.storeImage)
    .widthRatioToView(self.contentView,0.53).heightIs(50);
    
    
    self.timeImage.sd_layout
    .leftEqualToView(self.title).bottomEqualToView(self.storeImage)
    .heightIs(20).widthIs(20);
    
    //    self.timeEnd.backgroundColor = [UIColor blueColor];
    self.timeEnd.sd_layout
    .leftSpaceToView(self.timeImage,2).bottomEqualToView(self.timeImage)
    .widthRatioToView(self.contentView,0.38).heightIs(20);
    
    self.peopleImage.sd_layout
    .leftSpaceToView(self.timeEnd,5)
    .bottomEqualToView(self.timeEnd).widthIs(20)
    .topEqualToView(self.timeEnd);
    
    self.peopleCount.sd_layout
    .leftSpaceToView(self.peopleImage,0).bottomEqualToView(self.timeEnd)
    .rightSpaceToView(self.contentView,5).topEqualToView(self.timeEnd);
    
    
    self.ignoreBtn.sd_layout
    .rightSpaceToView(self.contentView,20).topSpaceToView(self.contentView,15)
    .widthIs(35).heightIs(20);
    
    self.notInvolved.sd_layout
    .rightSpaceToView(self.contentView,5).topSpaceToView(self.ignoreBtn,3)
    .widthIs(50).heightIs(20);
    

}
@end
