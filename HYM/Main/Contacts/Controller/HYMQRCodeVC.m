//
//  HYMQRCodeVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMQRCodeVC.h"
#import <CoreImage/CoreImage.h>
@interface HYMQRCodeVC ()

@property (nonatomic,strong)UIView *qrView;//二维码背景
@property (nonatomic,strong)UIImageView *qrImageView;//二维码
@end

@implementation HYMQRCodeVC


- (UIView *)qrView{

    if (_qrView == nil) {
        _qrView = [[UIView alloc] init];
        _qrView.layer.borderColor = [UIColor brownColor].CGColor;
        _qrView.layer.borderWidth = 1;
        _qrView.layer.cornerRadius = 10
        ;
        
    }
    return _qrView;
}

- (UIImageView *)qrImageView{

    if (_qrImageView ==nil ) {
        
        _qrImageView = [[UIImageView alloc] init];
    }
    return _qrImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];
    //生成二维码
    [self initWithQRCode];
    
}

- (void)initDefault{

    self.title = @"二维码名片";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)initWithView{

    [self.view addSubview:self.qrView];
    [self.qrView addSubview:self.qrImageView];
    
    //宽高160
    self.qrView.sd_layout
    .leftSpaceToView(self.view,80).rightSpaceToView(self.view,80)
    .topSpaceToView(self.view,35).heightIs(160);
    
    self.qrImageView.backgroundColor = [UIColor brownColor];
    self.qrImageView.sd_layout
    .leftSpaceToView(self.qrView,20).topSpaceToView(self.qrView,20)
    .rightSpaceToView(self.qrView,20).bottomSpaceToView(self.qrView,20);
    
    
    NSArray *titleArr = @[@"我已经在薅羊毛App赚了300元了",@"抓紧下载吧!"];
    for (int i = 0; i < 2; i++) {
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(50,kScreenHeight-200+ i*35 + 50, kScreenWitdth - 100, 1);
        lineView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:lineView];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(50, kScreenHeight-180+i*35, kScreenWitdth-100, 33);
        title.font = [UIFont systemFontOfSize:14];
        title.textColor = [UIColor orangeColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = titleArr[i];
        [self.view addSubview:title];
    }
    
    
}

- (void)initWithQRCode{

    //1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //2.恢复滤镜的默认属性
    [filter setDefaults];
    //3.给滤镜添加数据----数据添加
    NSString *datasString = @"http://www.jianshu.com";
    NSData *data = [datasString dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    //5.显示二维码
//    self.qrImageView.image = [UIImage imageWithCIImage:outputImage];
    
    //6.转换为高清的二维码
    self.qrImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:160];
}

#pragma mark 高清二维码
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //1.创建bitmap
    size_t width  = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
}
@end
