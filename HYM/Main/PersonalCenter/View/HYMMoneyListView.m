//
//  HYMInfoView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/16.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMoneyListView.h"

@interface HYMMoneyListView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//@property (nonatomic,strong)UIImagePickerController *imagePC;
@property (nonatomic,strong)UIImageView *iconImage;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@end
@implementation HYMMoneyListView


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
   
}




@end
