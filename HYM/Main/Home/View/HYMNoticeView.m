//
//  HYMNoticeView.m
//  首页
//
//  Created by 刘晓雪 on 16/4/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMNoticeView.h"
#import "ScrollLabel.h"
@interface HYMNoticeView ()<ScrollLabelDelegate>

@property (nonatomic,strong)ScrollLabel *scrollLabel;//公告
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIImageView *hornImage;
@property (nonatomic,strong)UIButton *messageBtn;//消息按钮
@property (nonatomic,strong)UILabel *colon;//冒号
@property (nonatomic,strong)NSArray *titleArr;//公告消息


@end

@implementation HYMNoticeView

#pragma mark 懒加载
- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(20, 10, 80, 20);
        _title.textColor = [UIColor blackColor];
        _title.text = @"官方公告";
        _title.font = [UIFont boldSystemFontOfSize:15];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor whiteColor];
    }
    
    return _title;
}

//喇叭图标
-(UIImageView *)hornImage{

    if (_hornImage == nil) {
        
        _hornImage = [[UIImageView  alloc] init];
        _hornImage.frame = CGRectMake(5, 10, 20, 20);
        _hornImage.backgroundColor = [UIColor brownColor];
    }
    
    return _hornImage;
}

-(UIButton *)messageBtn{

    if (_messageBtn == nil) {
        
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    
    return _messageBtn;
}

- (UILabel *)colon{

    if (_colon == nil) {
        
        _colon = [[UILabel alloc] init];
        _colon.frame = CGRectMake(90, 10, 10, 20);
        _colon.textAlignment = NSTextAlignmentCenter;
        _colon.text = @":";
        _colon.textColor = [UIColor whiteColor];
    }
    
    return _colon;
}

- (NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"数据1",@"数据2",@"数据3"];
    }
    
    return _titleArr;
}

-(ScrollLabel *)scrollLabel{

    if (_scrollLabel == nil) {
        
        _scrollLabel = [[ScrollLabel alloc] initWithFrame:CGRectMake(100, 10, 170, 20) withTitleArr:self.titleArr];
        _scrollLabel.scrollLabelDelegate = self;
        
    }
    
    return _scrollLabel;

}

#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        //此处颜色值修改
        self.backgroundColor = [UIColor lightGrayColor];
     
        [self initWithView];
        
    }
    
    return self;
}

#pragma mark 
- (void)initWithView{

    [self addSubview:self.title];
    [self addSubview:self.hornImage];
    [self addSubview:self.colon];
    [self addSubview:self.scrollLabel];
    
    
//    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(self.notice.mas_left);
//        make.top.mas_equalTo(10);
//        make.bottom.mas_equalTo(-10);
//    }];
//    
//    [self.notice mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.mas_equalTo(50);
//        make.right.mas_equalTo(self.colon.mas_left).offset(-20);
//        make.top.mas_equalTo(self.title.mas_top);
//        make.bottom.mas_equalTo(self.title.mas_bottom);
//    }];
//    
//    [self.colon mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.mas_equalTo(self.scrollLabel.mas_left).offset(-5);
//        make.top.mas_equalTo(self.title.mas_top);
//        make.bottom.mas_equalTo(self.title.mas_bottom);
//        make.right.mas_equalTo(self.scrollLabel.mas_left);
//        
//    }];
}

#pragma mark 公告实现方法
- (void)btnClick:(UIButton *)btn{

   NSLog(@"%ld",(long)btn.tag);
}
@end
