//
//  HYMTaskRecord.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMTaskRecord : UIView

//任务流程
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *taskRecord;//任务流程
@property (nonatomic,strong)UIImageView *imageView;//流程图
@property (nonatomic,strong)UILabel *officialContent;//官方
@property (nonatomic,strong)UILabel *officialWebsite;//官方网址
@property (nonatomic,strong)UILabel *moreContent;//更多内容
@property (nonatomic,strong)UILabel *officeNumber;//官方电话

//用户评价
@property (nonatomic,strong)UIView *userline;
@property (nonatomic,strong)UILabel *userEvaluation;//用户评价
@property (nonatomic,strong)UILabel *zan;

@property (nonatomic,strong)UIView *bottomLine;
@property (nonatomic,strong)UIView *sliderView;
@end