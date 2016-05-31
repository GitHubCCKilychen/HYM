//
//  HYMConModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMConModel : BaseModel
@property (nonatomic,copy)NSString *invite_url;
@property (nonatomic,copy)NSString *first;//一级粉丝
@property (nonatomic,copy)NSString *first_income;//收益
@property (nonatomic,copy)NSString *first_percent;//提成
@property (nonatomic,copy)NSString *second;//二级粉丝
@property (nonatomic,copy)NSString *second_income;//收益
@property (nonatomic,copy)NSString *second_percent;//提成
@property (nonatomic,copy)NSString *invite_code;//邀请码
@property (nonatomic,copy)NSString *total;//邀请返利
@end
