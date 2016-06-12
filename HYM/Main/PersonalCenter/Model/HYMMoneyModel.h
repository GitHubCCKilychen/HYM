//
//  HYMMoneyModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMMoneyModel : BaseModel

@property (nonatomic,copy)NSString *realname;
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *froze_money;
@property (nonatomic,copy)NSString *cash_deposit;//保证金
@end
