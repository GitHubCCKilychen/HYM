//
//  HYMJoinView.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMTaskDetailModel.h"
@interface HYMJoinView : UIView
@property (nonatomic,strong)HYMTaskDetailModel *model;
@property (nonatomic,strong)UIView *redView;
@property (nonatomic,strong)UILabel *participatingAddress;//参与地址
@property (nonatomic,strong)UILabel *link;
@property (nonatomic,strong)UIButton *Btn;
@property (nonatomic,strong)UILabel *bottomTitle;
@end
