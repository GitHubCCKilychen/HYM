//
//  HYMTaskDetailModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/11.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMTaskDetailModel : BaseModel

@property (nonatomic,copy)NSString *logo;
@property (nonatomic,copy)NSString *benjin;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *task_number;
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *content_link;//链接地址
@end
