//
//  HYMTableViewCell.m
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTableViewCell.h"
#define kTopWidth kScreenWitdth-30-(kScreenWitdth/2-kScreenWitdth/6)

@implementation HYMTableViewCell
#pragma mark cell1
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
        _title.text = @"本金x元，期限x天";
        _title.backgroundColor = [UIColor brownColor];
        
    }
    
    return _title;
}

- (UILabel *)subTitle{
    
    if (_subTitle == nil) {
        
        _subTitle = [[UILabel alloc] init];
        _subTitle.backgroundColor = [UIColor grayColor];
        
    }
    
    return _subTitle;
}

- (UIImageView *)hotImage{
    
    if (_hotImage == nil) {
        
        _hotImage = [[UIImageView alloc] init];
        _hotImage.backgroundColor = [UIColor orangeColor];
    }
    return _hotImage;
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
        _peopleCount.backgroundColor = [UIColor greenColor];
    }
    return _peopleCount;
    
}
- (UILabel *)timeEnd{

    if (_timeEnd == nil) {
        
        _timeEnd = [[UILabel alloc] init];
        _timeEnd.backgroundColor = [UIColor grayColor];
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
        _ignoreBtn.backgroundColor = [UIColor greenColor];
    }
    return _ignoreBtn;
}
#pragma mark 懒加载cell2
- (UIButton *)leftBtn{

    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = [UIColor grayColor];
    }
    
    return _leftBtn;
}

- (UIButton *)topBtn{

    if (_topBtn == nil) {
        
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.backgroundColor =[UIColor brownColor];
    }
    
    return _topBtn;

}

-(UIButton *)rightBtn{

    if (_rightBtn == nil) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor brownColor];
    }
    return _rightBtn;
}
- (UIButton *)centerBtn{

    if (_centerBtn == nil) {
        
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.backgroundColor = [UIColor greenColor];
    }
    
    return _centerBtn;
}

#pragma mark cell3

-(UIImageView *)leftImageView{

    if (_leftImageView == nil) {
        
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor grayColor];
    }
    return _leftImageView;
}

-(UILabel *)titleInforation{

    if (_titleInforation == nil) {
        _titleInforation = [[UILabel alloc] init];
        _titleInforation.text = @"上海震荡收涨成交量大幅萎缩234565789009987685667564456";
        [HYMTool initLabel:_titleInforation withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        _titleInforation.numberOfLines = 0;
    }
    return _titleInforation;
}


- (UILabel *)time{

    if (_time == nil) {
        
        _time = [[UILabel alloc] init];
        _time.layer.borderColor = [UIColor redColor].CGColor;
        _time.textColor = [UIColor grayColor];
        _time.text = @"2016:10:12222";
        _time.font = [UIFont systemFontOfSize:13];
        _time.textAlignment = NSTextAlignmentLeft;
        
        
    }
    
    return _time;
}

-(UILabel *)comment{

    if (_comment == nil) {
        
        _comment = [[UILabel alloc] init];
        _comment.text = @"11900评论";
        _comment.backgroundColor = [UIColor greenColor];
        _comment.font = [UIFont systemFontOfSize:10];
        _comment.textColor = [UIColor grayColor];
    }
    
    return _comment;
}

#pragma mark cell自定义
- (void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
    
    if (_indexPath.section == 0) { [self initCell1];
        
        
    }else if(_indexPath.section == 1){ [self initCell2];
    
    }else if (_indexPath.section == 2){ [self initCell3];
    
    };
}

#pragma mark cell
- (void)initCell1{
    [self.contentView addSubview:self.storeImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.subTitle];
    [self.contentView addSubview:self.hotImage];
    [self.contentView addSubview:self.timeImage];
    [self.contentView addSubview:self.timeEnd];
    [self.contentView addSubview:self.peopleCount];
    [self.contentView addSubview:self.peopleImage];
    [self.contentView addSubview:self.ignoreBtn];
    
    
    self.storeImage.sd_layout
    .leftSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15).widthRatioToView(self.contentView,0.2);
    
    self.title.sd_layout
    .leftSpaceToView(self.storeImage,5).topEqualToView(self.storeImage)
    .widthRatioToView(self.contentView,0.5).heightIs(20);
    
    self.subTitle.sd_layout
    .leftEqualToView(self.title).topSpaceToView(self.title,3)
    .heightIs(20).widthRatioToView(self.contentView,0.6);
    
    self.timeImage.sd_layout
    .leftEqualToView(self.title).bottomEqualToView(self.storeImage)
    .heightIs(20).widthIs(20);
    
    self.timeEnd.sd_layout
    .leftSpaceToView(self.timeImage,2).bottomEqualToView(self.timeImage)
    .widthRatioToView(self.contentView,0.3).heightIs(20);
    
    self.peopleImage.sd_layout
    .leftSpaceToView(self.timeEnd,2).rightSpaceToView(self.contentView,10)
    .bottomEqualToView(self.timeEnd).widthEqualToHeight(20)
    .topEqualToView(self.timeEnd);
    
    self.peopleCount.sd_layout
    .leftSpaceToView(self.peopleImage,1).bottomEqualToView(self.timeEnd)
    .rightSpaceToView(self.contentView,10).topEqualToView(self.timeEnd);
    
    self.hotImage.sd_layout
    .leftSpaceToView(self.title,15).topEqualToView(self.title)
    .bottomEqualToView(self.title).widthEqualToHeight(20);
 
    self.ignoreBtn.sd_layout
    .leftSpaceToView(self.hotImage,5).bottomEqualToView(self.hotImage)
    .topEqualToView(self.hotImage).rightSpaceToView(self.contentView,10)
    .widthIs(40);

}

- (void)initCell2{

    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.topBtn];
    [self.contentView addSubview:self.centerBtn];
    [self.contentView addSubview:self.rightBtn];

    self.leftBtn.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,15)
    .widthRatioToView(self.contentView,0.4)
    .heightRatioToView(self.contentView,0.8);
    
    self.topBtn.sd_layout
    .topEqualToView(self.leftBtn)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.leftBtn,1)
    .heightIs(59);
    
    self.centerBtn.sd_layout
    .leftEqualToView(self.topBtn)
    .bottomEqualToView(self.leftBtn)
    .topSpaceToView(self.topBtn,1)
    .heightIs(59)
    .widthRatioToView(self.topBtn,0.5);
    
    self.rightBtn.sd_layout
    .topEqualToView(self.centerBtn)
    .leftSpaceToView(self.centerBtn,1)
    .bottomEqualToView(self.centerBtn)
    .rightEqualToView(self.topBtn);
    
}


- (void)initCell3{

    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleInforation];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.comment];
    
    
    self.leftImageView.sd_layout
    .leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,15).widthRatioToView(self.contentView,0.3);
    
//    self.titleInforation.backgroundColor =[UIColor grayColor];
    self.titleInforation.sd_layout
    .leftSpaceToView(self.leftImageView,10).topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,15).widthRatioToView(self.contentView,0.6)
    .heightRatioToView(self.leftImageView,0.5);
    
    self.comment.sd_layout
    .leftEqualToView(self.titleInforation).topSpaceToView(self.titleInforation,15)
    .bottomEqualToView(self.leftImageView).widthRatioToView(self.leftImageView,0.6);
    
    self.time.sd_layout
    .leftSpaceToView(self.comment,15).topEqualToView(self.comment)
    .bottomEqualToView(self.comment).rightEqualToView(self.titleInforation);
    
}


#pragma mark cell2点击事件
- (void)leftBtnAct:(UIButton *)btn{

}

- (void)topBtnAct:(UIButton *)btn{

}

- (void)centerBtnAct:(UIButton *)btn{

}

- (void)rightBtnAct:(UIButton *)btn{

    
}
@end
