//
//  HYMLunTanCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMLunTanCell.h"

@implementation HYMLunTanCell

- (UIImageView *)iconImage{

    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = [UIColor grayColor];
    }
    return _iconImage;
}

- (UILabel *)userName{

    if (_userName == nil) {
        
        _userName = [[UILabel alloc] init];
        _userName.text = @"简简单单";
        [HYMTool initLabel:_userName withFont:[UIFont systemFontOfSize:17] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _userName;
}

- (UILabel *)time{

    if (_time == nil) {
        
        _time = [[UILabel alloc] init];
        _time.text = @"10分钟之前";
        [HYMTool initLabel:_time withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor grayColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _time;
}

- (UILabel *)connent{

    if (_connent == nil) {
        
        _connent = [[UILabel alloc] init];
        _connent.text = @"活动出来2个月了，小编的燃着不能说生命什么";
        [HYMTool initLabel:_connent withFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _connent;
}

- (UILabel *)connentTitle{

    if (_connentTitle == nil) {
        
        _connentTitle = [[UILabel alloc] init];
        _connentTitle.text = @"一元提现，比好运购物更加给力！推广一元购物的活动开始了呢34456779";
        _connentTitle.numberOfLines = 0;
        [HYMTool initLabel:_connentTitle withFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _connentTitle;
}

- (UIButton *)deleteBtn{

    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_deleteBtn setImage:[UIImage imageNamed:@"luntanDelete"] forState:UIControlStateNormal];
        //上左下右10，10，10，60
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 15);
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//
        
    }
    return _deleteBtn;
}

- (UIButton *)readBtn{

    if (_readBtn == nil) {
        
        _readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_readBtn setImage:[UIImage imageNamed:@"luntanyuedu"] forState:UIControlStateNormal];
        //上左下右10，10，10，60
        _readBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0,0, 22);
        [_readBtn setTitle:@"0" forState:UIControlStateNormal];
        _readBtn.titleEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [_readBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _readBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _readBtn;
}

- (UIButton *)commentBtn{

    if (_commentBtn == nil) {
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_commentBtn setImage:[UIImage imageNamed:@"luntanPinglun"] forState:UIControlStateNormal];
        //上左下右10，10，10，60
        _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, -2, -3, 20);
        [_commentBtn setTitle:@"0" forState:UIControlStateNormal];
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _commentBtn;
}

- (UIButton *)zanBtn{

    if (_zanBtn == nil) {
        
        _zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_zanBtn setImage:[UIImage imageNamed:@"luntanZan"] forState:UIControlStateNormal];
        //上左下右10，10，10，60
        _zanBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, -2, -3, 20);
        [_zanBtn setTitle:@"0" forState:UIControlStateNormal];
        _zanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_zanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _zanBtn;
}

- (UIButton *)tagTitle{

    if (_tagTitle == nil) {
        
        _tagTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_tagTitle setImage:[UIImage imageNamed:@"luntanbiaoqian "] forState:UIControlStateNormal];
        //上左下右10，10，10，60
        _tagTitle.imageEdgeInsets = UIEdgeInsetsMake(-3, -2, -3, 20);
        [_tagTitle setTitle:@"10元薅" forState:UIControlStateNormal];
        _tagTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tagTitle setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _tagTitle.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _tagTitle;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithView];
    }
    return  self;
}

- (void)initWithView{

    
    //在4傻姑娘有问题
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.connent];
    [self.contentView addSubview:self.connentTitle];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.readBtn];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.zanBtn];
    [self.contentView addSubview:self.tagTitle];
    
    
    self.iconImage.sd_layout
    .leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,15)
    .widthIs(40).heightIs(40);
    
    self.userName.sd_layout
    .leftSpaceToView(self.iconImage,15).topSpaceToView(self.contentView,15)
    .widthRatioToView(self.contentView,0.4).heightIs(25);
    
    
    self.time.sd_layout
    .leftSpaceToView(self.iconImage,15).topSpaceToView(self.userName,5)
    .heightIs(10).widthRatioToView(self.contentView,0.25);
    
    self.connentTitle.sd_layout
    .leftSpaceToView(self.contentView,15).topSpaceToView(self.time,15)
    .rightSpaceToView(self.contentView,15).bottomSpaceToView(self.contentView,40);
    self.connent.sd_layout
    .leftSpaceToView(self.contentView,15).topSpaceToView(self.connentTitle,5).rightSpaceToView(self.contentView,15).heightIs(20);
    self.deleteBtn.sd_layout
    .rightSpaceToView(self.contentView,15).bottomSpaceToView(self.connentTitle,0).widthIs(35).heightIs(25);
    
    self.tagTitle.sd_layout
    .rightSpaceToView(self.deleteBtn,18).bottomEqualToView(self.deleteBtn)
    .widthIs(50).heightIs(25);
    
    self.zanBtn.sd_layout
    .rightSpaceToView(self.contentView,15).topSpaceToView(self.contentView,15)
    .heightIs(25).widthIs(30);
    
    
    self.commentBtn.sd_layout
    .rightSpaceToView(self.zanBtn,10).topSpaceToView(self.contentView,15)
    .heightIs(25).widthIs(30);
    
    self.readBtn.sd_layout
    .rightSpaceToView(self.commentBtn,10).topSpaceToView(self.contentView,15)
    .heightIs(25).widthIs(30);
    
    
}
@end
