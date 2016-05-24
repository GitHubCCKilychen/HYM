//
//  HYMEditCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMEditCell.h"

@implementation HYMEditCell

- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.layer.cornerRadius = 3;
        _lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _lineView.layer.borderWidth = 0.5;
        
    }
    return _lineView;
}

- (UIView *)connectLine{

    if (_connectLine ==nil) {
        
        _connectLine = [[UIView alloc] init];
        _connectLine.layer.cornerRadius = 3;
        _connectLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _connectLine.layer.borderWidth = 0.5;

    }
    return _connectLine;
}

- (UITextField *)title{

    if (_title == nil) {
        
        _title = [[UITextField alloc] init];
        _title.placeholder = @"请输入标题（最多6个字符)";
        _title.textColor = [UIColor blackColor];
        
    }
    return _title;
}

- (UITextView *)connectView{

    if (_connectView == nil) {
        
        _connectView = [[UITextView alloc] init];
        _connectView.text = @"请输入内容";
    }
    return _connectView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        
        [self initView];
    }
    return self;
}

- (void)initView{

//    [self.contentView addSubview:self.lineView];
//    [self.contentView addSubview:self.connectLine];
//    [self.lineView addSubview:self.title];
//    [self.connectLine addSubview:self.connectView];
    
    
    self.lineView.sd_layout
    .leftSpaceToView(self.contentView,15).rightSpaceToView(self.contentView,15)
    .heightIs(35).topSpaceToView(self.contentView,10);
    

    self.title.sd_layout
    .leftSpaceToView(self.lineView,2).rightSpaceToView(self.lineView,2)
    .topSpaceToView(self.lineView,5).bottomSpaceToView(self.lineView,5);
    
    self.connectLine.sd_layout
    .leftEqualToView(self.lineView).rightEqualToView(self.lineView)
    .topSpaceToView(self.lineView,10).heightIs(100);
    
    
    self.connectView.sd_layout
    .leftSpaceToView(self.connectLine,2).rightSpaceToView(self.connectLine,2)
    .topSpaceToView(self.connectLine,5).bottomSpaceToView(self.connectLine,5);
    
}
@end
