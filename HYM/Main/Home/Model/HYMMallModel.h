//
//  HYMMallModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMMallModel : BaseModel
/**
 *    blogtype = 2;
 costcode = "******";
 id = 2597;
 imgItems = "<null>";
 imgurl0 = "http://101.200.84.33/uploadfiles/2016/02/201602201443418309_thumb.png";
 name = "\U8f7b\U4fbf\U6c34\U997a\U5305";
 price = "9.90";
 */

@property (nonatomic,copy)NSString *blogtype;
@property (nonatomic,copy)NSString *imgItems;
@property (nonatomic,copy)NSString *imgurl0;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *price;
@end
