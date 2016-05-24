//
//  HYMInfoView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/16.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInfoView.h"

@interface HYMInfoView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//@property (nonatomic,strong)UIImagePickerController *imagePC;
@property (nonatomic,strong)UIImageView *iconImage;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@end
@implementation HYMInfoView


-(UIImageView *)iconImage{
    
    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc] init];
        _iconImage.frame =CGRectMake(kScreenWitdth/2-30, 120/2-30, 60, 60);
        _iconImage.layer.cornerRadius = 30;
        _iconImage.userInteractionEnabled = YES;
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
        _iconImage.clipsToBounds = YES;
        _iconImage.backgroundColor = [UIColor grayColor];
        
    }
    
    return _iconImage;
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor= [UIColor colorWithRed:240/256.f green:240/256.f blue:240/256.f alpha:1];
        [self initWithView];
    }
    
    return self;
}


- (void)initWithView{
    
    [self addSubview:self.iconImage];
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraBtnClick:)];
    [self.iconImage addGestureRecognizer:tap];
}
//-----此处有问题
- (void)cameraBtnClick:(UIButton *)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    [self.actionSheet showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                //来源:相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                //来源:相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    }
    else {
        if (buttonIndex == 1) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self.viewController presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    //赋值
    self.iconImage.image= [info objectForKey:UIImagePickerControllerOriginalImage];

    
}




@end
