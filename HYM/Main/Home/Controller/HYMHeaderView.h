//
//  HYMHeaderView.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/4.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMInfoTableView.h"
@interface HYMHeaderView : UIView

@property (nonatomic,weak)UIButton *button;
@property (nonatomic,weak)UIView *lineView;
@property (nonatomic,strong)HYMInfoTableView *infoTable;
@end
