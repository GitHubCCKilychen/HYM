//
//  HYMCommunityCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommunityCell.h"

@implementation HYMCommunityCell

- (void)awakeFromNib {

    //添加长按手势
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesAct:)];
 
    [self addGestureRecognizer:longGes];
}

#pragma mark 长按

- (void)longGesAct:(UILongPressGestureRecognizer *)longGes{
    //获取当前的版本信息
    
    
 
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)delete:(UIButton *)sender {
    
    float iOSVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (iOSVersion < 8.0f) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        
        [alert show];
    }
    
    
    //删除
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self.viewController presentViewController:alertVC animated:YES completion:nil];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //此处重新设置cell的个数值
        
        
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alertVC addAction:delete];
    [alertVC addAction:cancle];
}
@end
