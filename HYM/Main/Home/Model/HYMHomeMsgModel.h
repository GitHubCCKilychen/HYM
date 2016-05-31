//
//  HYMHomeMsgModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMHomeMsgModel : BaseModel
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *regdate;
@end
