//
//  HYMTaskModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMTaskModel : BaseModel

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *logo;
@property (nonatomic,copy)NSString *start_time;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *join_number;
@property (nonatomic,copy)NSString *taskID;
@end
