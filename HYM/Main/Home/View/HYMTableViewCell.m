//
//  HYMTableViewCell.m
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTableViewCell.h"

@implementation HYMTableViewCell
#pragma mark cell1
-(UIImageView *)storeImage{
    
    if (_storeImage == nil) {
        _storeImage = [[UIImageView alloc] init];
        _storeImage.backgroundColor = [UIColor grayColor];
        _storeImage.frame = CGRectMake(20, 15, 70, 80);
        
    }
    
    return _storeImage;
}

-(UILabel *)title{
    
    if (_title ==nil) {
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(100, 15, self.frame.size.width/2, 20);
        _title.text = @"本金x元，期限x天";
        _title.backgroundColor = [UIColor brownColor];
        
    }
    
    return _title;
}

- (UILabel *)subTitle{
    
    if (_subTitle == nil) {
        
        _subTitle = [[UILabel alloc] init];
        _subTitle.frame = CGRectMake(100, 35, self.frame.size.width/2+30, 20);
        _subTitle.backgroundColor = [UIColor grayColor];
        
    }
    
    return _subTitle;
}

- (UIImageView *)hotImage{
    
    if (_hotImage == nil) {
        
        _hotImage = [[UIImageView alloc] init];
        _hotImage.frame = CGRectMake(self.frame.size.width-70, 15, 15, 15);
        _hotImage.backgroundColor = [UIColor orangeColor];
    }
    return _hotImage;
}
-(UIImageView *)timeImage{
    
    if (_timeImage == nil) {
        _timeImage = [[UIImageView alloc] init];
        _timeImage.frame = CGRectMake(100, 75, 20, 20);
        _timeImage.backgroundColor = [UIColor grayColor];
    }
    
    return _timeImage;
}
#pragma mark 懒加载cell2
- (UIButton *)leftBtn{

    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(15, 15, self.frame.size.width/2-30, 130);
        _leftBtn.backgroundColor = [UIColor grayColor];
    }
    
    return _leftBtn;
}

- (UIButton *)topBtn{

    if (_topBtn == nil) {
        
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.frame = CGRectMake(self.frame.size.width/2-14, 15, self.frame.size.width/2, 64);
        _topBtn.backgroundColor =[UIColor brownColor];
    }
    
    return _topBtn;

}

-(UIButton *)rightBtn{

    if (_rightBtn == nil) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.frame.size.width/2-13+self.frame.size.width/4, 80, self.frame.size.width/4,65);
        _rightBtn.backgroundColor = [UIColor brownColor];
    }
    return _rightBtn;
}
- (UIButton *)centerBtn{

    if (_centerBtn == nil) {
        
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.frame = CGRectMake(self.frame.size.width/2-14, 80, self.frame.size.width/4, 65);
        _centerBtn.backgroundColor = [UIColor greenColor];
    }
    
    return _centerBtn;
}

#pragma mark cell3

-(UIImageView *)leftImageView{

    if (_leftImageView == nil) {
        
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.frame = CGRectMake(15, 15, 110, 80);
        _leftImageView.backgroundColor = [UIColor grayColor];
    }
    return _leftImageView;
}

-(UILabel *)titleInforation{

    if (_titleInforation == nil) {
        _titleInforation = [[UILabel alloc] init];
        _titleInforation.frame = CGRectMake(135, 15, self.frame.size.width/2+10, 20);
        _titleInforation.text = @"上海震荡收涨成交量大幅萎缩";
        _titleInforation.font = [UIFont systemFontOfSize:13];
    
    }
    return _titleInforation;
}

- (UILabel *)subTitleLabel{

    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.frame = CGRectMake(135, 30, self.frame.size.width/2+10, 40);
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.text = @"上海震荡收涨成交量大幅萎缩1234567890";
        _subTitleLabel.lineBreakMode = UILineBreakModeWordWrap;
        _subTitleLabel.textColor = [UIColor grayColor];
      
    }
    return _subTitleLabel;
}

- (UILabel *)topicLabel{

    if (_topicLabel == nil) {
        
        _topicLabel = [[UILabel alloc] init];
        _topicLabel.frame = CGRectMake(135, 75, 35, 18);
        _topicLabel.layer.borderColor = [UIColor redColor].CGColor;
        _topicLabel.textColor = [UIColor redColor];
        _topicLabel.layer.borderWidth = 1;
        _topicLabel.layer.cornerRadius = 3;
        _topicLabel.layer.masksToBounds = YES;
        _topicLabel.text = @"专题";
        _topicLabel.font = [UIFont systemFontOfSize:13];
        _topicLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    
    return _topicLabel;
}

-(UILabel *)comment{

    if (_comment == nil) {
        
        _comment = [[UILabel alloc] init];
        _comment.frame = CGRectMake(175, 75, 150, 18);
        _comment.text = @"羊毛要闻－阅读：1232";
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
}

- (void)initCell2{

    [self addSubview:self.leftBtn];
    [self addSubview:self.topBtn];
    [self addSubview:self.centerBtn];
    [self addSubview:self.rightBtn];
}


- (void)initCell3{

    [self addSubview:self.leftImageView];
    [self addSubview:self.titleInforation];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.topicLabel];
    [self addSubview:self.comment];

}


@end
