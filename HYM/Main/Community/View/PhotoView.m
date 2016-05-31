//
//  PhotoView.m
//  lianxi
//
//  Created by 刘晓雪 on 16/5/29.
//  Copyright © 2016年 weifuwangluo. All rights reserved.
//

#import "PhotoView.h"
#import <UIView+SDAutoLayout.h>
#import "UIView+UIViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation PhotoView

- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.text = @"拍照样例";
        
    }
    return _title;
}

- (UIImageView *)iconImage{

    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)Explanation{

    if (_Explanation == nil) {
        _Explanation = [[UILabel alloc] init];
        _Explanation.text = @"说明:";
        _Explanation.textColor = [UIColor orangeColor];
    }
    return _Explanation;
}
- (UIButton *)photo{

    if (_photo == nil) {
        
        _photo = [UIButton buttonWithType:UIButtonTypeSystem];
        _photo.layer.borderColor = [UIColor orangeColor].CGColor;
        _photo.layer.borderWidth = 0.5;
        _photo.layer.cornerRadius = 3;
        [_photo setTitle:@"跳过，拍照" forState:UIControlStateNormal];
        _photo.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_photo setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_photo addTarget:self action:@selector(photoAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photo;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView{

    [self addSubview:self.title];
    [self addSubview:self.iconImage];
    [self addSubview:self.Explanation];
    [self addSubview:self.photo];
    
    CGFloat iconImageHeight = self.frame.size.height*0.5;
    
    self.photo.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,15)
    .bottomSpaceToView(self,10).heightIs(40);

    
    self.title.sd_layout
    .leftSpaceToView(self,kScreenWidth/2-50).rightSpaceToView(self,kScreenWidth/2-50)
    .topSpaceToView(self,15).heightIs(20);
    
    self.iconImage.backgroundColor = [UIColor lightGrayColor];
    self.iconImage.sd_layout
    .leftSpaceToView(self,10).rightSpaceToView(self,10)
    .topSpaceToView(self.title,10).heightIs(iconImageHeight);
    
    self.Explanation.sd_layout
    .leftSpaceToView(self,15).widthIs(40).heightIs(20)
    .topSpaceToView(self.iconImage,10);
    
    NSArray *titleArr = @[@"确保身份证上的信息没有被遮挡",@"确保证件内容清晰可见"];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(15, self.frame.size.height*0.7+10+i*10+i*10, 4, 15);
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(25,  self.frame.size.height*0.7+10+i*10+i*10, kScreenWidth-25, 15);
        title.text = titleArr[i];
        title.textColor = [UIColor grayColor];
        title.font = [UIFont systemFontOfSize:13];
        [self addSubview:title];

        
    }
}
#pragma mark 拍照
- (void)photoAct:(UIButton *)btn{
    
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
