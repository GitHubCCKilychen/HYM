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
 *          "apply_status" = 0;
            feeaccount = "101.20";
            "froze_money" = "0.00";
            nickname = "\U7cfb\U7edf\U7ba1\U7406\U5458";
            "total_money" = "101.2";

 */

@property (nonatomic,copy)NSString *apply_status;
@property (nonatomic,copy)NSString *feeaccount;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *total_money;
@end
