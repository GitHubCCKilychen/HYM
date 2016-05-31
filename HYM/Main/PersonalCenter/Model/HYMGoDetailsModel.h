//
//  HYMGoDetailsModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/24.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMGoDetailsModel : BaseModel
/**
 *"apply_msg" = "";
 "apply_status" = 1;
 avatar = "http://101.200.84.33/images/logo.png";
 feeaccount = "6471.25";
 "froze_money" = "0.00";
 id = 1;
 nickname = admin;
 sex = "\U7537";
 "total_money" = "6471.25";

 */

@property (nonatomic,copy)NSString *apply_status;
@property (nonatomic,copy)NSString *feeaccount;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *total_money;
@property (nonatomic,copy)NSString *avatar;//头像
@property (nonatomic,copy)NSString *froze_money;
@end
