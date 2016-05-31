//
//  PhotoView.h
//  lianxi
//
//  Created by 刘晓雪 on 16/5/29.
//  Copyright © 2016年 weifuwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *Explanation;
@property (nonatomic,strong)UIButton *photo;
@property (nonatomic,strong)UIImagePickerController *pickVC;
@end
