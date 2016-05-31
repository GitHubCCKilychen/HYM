//
//  HYMFriendModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/25.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMFriendModel : BaseModel
/**
 *   avatar = "<null>";
 badge = 0;
 "client_id" = 2513;
 friends = 1;
 imgItems = "<null>";
 nickname = 151;
 */

@property (nonatomic,copy)NSString *avatar;//头像
@property (nonatomic,copy)NSString *badge;//消息
@property (nonatomic,copy)NSString *friends;//好友
@property (nonatomic,copy)NSString *imgItems;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *client_id;
@end
