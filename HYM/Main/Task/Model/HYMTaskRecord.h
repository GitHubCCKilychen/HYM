//
//  HYMTaskRecord.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMTaskRecord : UIView


@property (nonatomic,strong)UIView *backView;//背景view
@property (nonatomic,assign)int newIndex;
@property (nonatomic,assign)int index;//任务ID
//任务流程
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *taskRecord;//任务流程
@property (nonatomic,strong)UIImageView *imageView;//流程图
//@property (nonatomic,strong)UILabel *officialContent;//官方
//@property (nonatomic,strong)UILabel *officialWebsite;//官方网址
@property (nonatomic,strong)UILabel *moreContent;//更多内容
@property (nonatomic,strong)UILabel *officeNumber;//官方电话
@property (nonatomic,strong)UIButton *chatBtn;//咨询

//用户评价
@property (nonatomic,strong)UIView *userline;
@property (nonatomic,strong)UILabel *userEvaluation;//用户评价
@end
