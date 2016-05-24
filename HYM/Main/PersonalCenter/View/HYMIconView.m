//
//  HYMIconView.m
//  注册
//
//  Created by 刘晓雪 on 16/4/19.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMIconView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface HYMIconView ()

@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UIImageView *topicImageView;
@property (nonatomic,strong)UILabel *topicTitle;
@property (nonatomic,strong)UIView *topicView;
@end

@implementation HYMIconView

-(UIImageView *)iconImage{

    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc] init];
        _iconImage.frame =CGRectMake(kScreenWidth/2-30, self.topicView.frame.size.height+30, 60, 60);
        _iconImage.backgroundColor = [UIColor grayColor];
        _iconImage.layer.cornerRadius = 30;
        _iconImage.userInteractionEnabled = YES;
        
    }
    
    return _iconImage;
}

- (UIView *)topicView{

    if (_topicView == nil) {
        
        _topicView = [[UIView alloc] init];
    }
    return _topicView;
}

- (UIImageView *)topicImageView{

    if (_topicImageView == nil) {
        
        _topicImageView = [[UIImageView alloc] init];
    }
    return _topicImageView;
}

- (UILabel *)topicTitle{

    if (_topicTitle == nil) {
        
        _topicTitle = [[UILabel alloc] init];
    }
    return _topicTitle;
}
- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor= [UIColor colorWithRed:240/256.f green:240/256.f blue:240/256.f alpha:1];
        [self initTopicView];
        [self initWithView];
    }
    
    return self;
}

- (void)initTopicView{

    [self addSubview:self.topicView];
    [self.topicView addSubview:self.topicImageView];
    [self.topicView addSubview:self.topicTitle];
    
    
    self.topicView.backgroundColor = [UIColor whiteColor];
    self.topicView.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0)
    .heightIs(50).widthIs(kScreenWidth);
    
    self.topicImageView.image = [UIImage imageNamed:@"ID"];
    self.topicImageView.sd_layout
    .leftSpaceToView(self.topicView,15).topSpaceToView(self.topicView,15)
    .bottomSpaceToView(self.topicView,15).widthIs(23);
    
    self.topicTitle.text = @"填写个人信息";
    self.topicTitle.textColor = [UIColor orangeColor];
    self.topicTitle.textAlignment = NSTextAlignmentLeft;
    self.topicTitle.font = [UIFont systemFontOfSize:15];
    self.topicTitle.sd_layout
    .leftSpaceToView(self.topicImageView,10).rightSpaceToView(self.topicView,0)
    .topEqualToView(self.topicImageView).heightIs(20);
    
}

- (void)initWithView{

    [self addSubview:self.iconImage];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhoto:)];
    [self.iconImage addGestureRecognizer:tap];
}

#pragma mark 图片选择
- (void)selectedPhoto:(UITapGestureRecognizer *)tap{

    //ios9 跟iOS8
    UIAlertController *alertVC= [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self.viewController presentViewController:alertVC animated:YES completion:nil];
    
    UIAlertAction *pic = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //进入相册选择图片
        
    }];
    
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //调用相机
        
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alertVC addAction:pic];
    [alertVC addAction:photo];
    [alertVC addAction:cancle];
    
}
@end
