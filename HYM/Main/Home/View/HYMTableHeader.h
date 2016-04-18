//
//  HYMTableHeader.h
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"
#import "HYMTaskView.h"
@interface HYMTableHeader : UIView

@property (nonatomic,strong)ScrollView *scrollView;

@property (nonatomic,strong)HYMTaskView *taskView;//中间部分
@end

