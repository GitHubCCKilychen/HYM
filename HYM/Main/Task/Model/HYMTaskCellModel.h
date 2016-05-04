//
//  HYMTaskCellModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMTaskCellModel : BaseModel

@property (nonatomic,copy)NSString *iconImage;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *zanImage;
@property (nonatomic,copy)NSString *zanCount;
@property (nonatomic,copy)NSString *comment;

@end
