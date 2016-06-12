//
//  HYMMallView.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/24.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMCenMallModel.h"
@interface HYMMallView : UIView

@property (nonatomic,strong)HYMCenMallModel *model;
@property (nonatomic,strong)NSMutableArray *datalist;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *topBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIButton *centerBtn;

@end
