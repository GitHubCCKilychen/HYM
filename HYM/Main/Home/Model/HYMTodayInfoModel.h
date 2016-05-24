//
//  HYMTodayInfoModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/19.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMTodayInfoModel : BaseModel

@property (nonatomic,copy)NSString *imgurl0;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *regdate;//更新时间
@property (nonatomic,assign)int  totalCount;//个数
@property (nonatomic,strong)NSString *msg;
@end
