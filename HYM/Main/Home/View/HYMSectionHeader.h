//
//  HYMSectionHeader.h
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMSectionHeader : UIView



@property (nonatomic,assign)NSInteger section;

@property (nonatomic,strong)UILabel *title;//组头视图标题
@property (nonatomic,strong)UIImageView *imageView;//返回按钮

@property (nonatomic,assign)NSInteger index;
@end
