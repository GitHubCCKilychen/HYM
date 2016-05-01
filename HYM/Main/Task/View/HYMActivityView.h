//
//  HYMActivityVC.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMActivityView : UIView

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *activity;
@property (nonatomic,strong)UILabel *activityContent;//活动内容
@property (nonatomic,strong)UIView *grayLine;//线
@property (nonatomic,strong)UIView *verticalLine;//竖线
@property (nonatomic,strong)UILabel *activityCourse;//活动教程
@property (nonatomic,strong)UILabel *courseContent;//教程内容
@property (nonatomic,strong)UIView *gray2Line;//
@end
