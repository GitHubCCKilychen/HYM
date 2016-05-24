//
//  HYMMyBookModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/19.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMMyBookModel : BaseModel
/**
 *  imgurl0 = "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2236829478,2490144720&fm=80";
 name = "\U8d5a\U5ba2\U5e2eAPP \U75af\U62a2\U7ea2\U5305 \U4e00\U5143\U8d77\U63d0\U73b0";
 regdate = "2016-04-25 22:51:16";
 */



@property (nonatomic,copy)NSString *imgurl0;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *regdate;
@end
