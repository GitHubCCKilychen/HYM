//
//  HYMTaskRecordModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMTaskRecordModel : BaseModel
@property (nonatomic,copy)NSString *audit_time;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *logo;
@property (nonatomic,copy)NSString *join_number;
@end
