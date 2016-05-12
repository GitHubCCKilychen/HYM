//
//  HYMTaskListModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/11.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMTaskListModel : BaseModel

/**
 *    "end_time" = "2016-10-01";
 id = 5;
 "join_number" = 399;
 "join_status" = "\U672a\U53c2\U4e0e";
 logo = "http://101.200.84.33/uploadfiles/2016/04/201604130852136033_thumb.png";
 "start_time" = "2016-04-01";
 title = "\U672c\U91d1100.00\U5143\Uff0c\U671f\U96500\U5929\n\U6295\U8d44\U6536\U76ca10.00\U5143\Uff0c\U4efb\U52a1\U8fd4\U52292.00\U5143";
 }
 */
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *logo;
@property (nonatomic,copy)NSString *start_time;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *join_number;
@end
