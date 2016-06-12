//
//  HYMInfoBottom.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/14.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMInforModel.h"
@interface HYMInfoBottom : UIView

@property (nonatomic,strong)HYMInforModel *model;
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *textFiledArr;
@property (nonatomic,strong)NSMutableArray *datalist;
@end
