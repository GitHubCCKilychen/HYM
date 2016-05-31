//
//  HYMUpModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMUpModel : BaseModel
/**
 *   logo = "http://101.200.84.33/uploadfiles/2016/04/201604130852136033_thumb.png"
 */
@property (nonatomic,copy)NSString *logo;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *taskID;
@end
