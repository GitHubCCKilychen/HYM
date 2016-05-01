//
//  HYMTaskView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskRecordView.h"

@implementation HYMTaskRecordView

#pragma mark 懒加载

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
        //
        //        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:_title.text];
        
    }
    
    return _title;
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

-(UIButton *)chatBtn{

    if (_chatBtn == nil) {
        
        _chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chatBtn.backgroundColor = [UIColor brownColor];
    }
    
    return _chatBtn;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{

    [self addSubview:self.storeImage];
    [self addSubview:self.title];

    [self addSubview:self.timeImage];
    [self addSubview:self.timeEnd];
    [self addSubview:self.peopleCount];
    [self addSubview:self.peopleImage];
    [self addSubview:self.chatBtn];
    
    self.storeImage.sd_layout
    .leftSpaceToView(self,10).bottomSpaceToView(self,15)
    .topSpaceToView(self,15).widthRatioToView(self,0.2);
    
    self.title.backgroundColor = [UIColor grayColor];
    self.title.sd_layout
    .leftSpaceToView(self.storeImage,5).topEqualToView(self.storeImage)
    .widthRatioToView(self,0.53).heightIs(50);
    
    
    self.timeImage.sd_layout
    .leftEqualToView(self.title).bottomEqualToView(self.storeImage)
    .heightIs(20).widthIs(20);
    
    //    self.timeEnd.backgroundColor = [UIColor blueColor];
    self.timeEnd.sd_layout
    .leftSpaceToView(self.timeImage,2).bottomEqualToView(self.timeImage)
    .widthRatioToView(self,0.38).heightIs(20);
    
    self.peopleImage.sd_layout
    .leftSpaceToView(self.timeEnd,5)
    .bottomEqualToView(self.timeEnd).widthIs(20)
    .topEqualToView(self.timeEnd);
    
    self.peopleCount.sd_layout
    .leftSpaceToView(self.peopleImage,0).bottomEqualToView(self.timeEnd)
    .rightSpaceToView(self,5).topEqualToView(self.timeEnd);
    
    //此处值根据图片来
    self.chatBtn.sd_layout
    .leftSpaceToView(self.title,10).topSpaceToView(self,10)
    .rightSpaceToView(self,15)
    .widthIs(40).heightIs(30);

}
@end
