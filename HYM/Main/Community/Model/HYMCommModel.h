//
//  HYMCommModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMCommModel : BaseModel

@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *regdate;
@property (nonatomic,copy)NSString *tagTitle;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *visitcount;
@property (nonatomic,copy)NSString *starscount;//点赞
@property (nonatomic,copy)NSString *replycount;//评论
@property (nonatomic,copy)NSString *public_name;
@property (nonatomic,copy)NSString *blogID;

@end
