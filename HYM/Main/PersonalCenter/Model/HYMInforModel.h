//
//  HYMInforModel.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "BaseModel.h"

@interface HYMInforModel : BaseModel

/**
 *  "add_time" = "2016-05-27";
 alipay = "sgyd.2006@aliyun.com";
 bank = "\U5efa\U8bbe\U94f6\U884c";
 "bank_card" = 62270023922103339034;
 "cash_deposit" = "1000.00";
 email = "sgyd.2006@aliyun.com";
 "first_audit_remarks" = "";
 "first_audit_status" = 1;
 "first_audit_time" = "2016-05-27";
 "id_card" = 370681198500152816;
 "id_card_back" = "http://123.56.237.91/uploadfiles/2016/05/201605271350198900.jpg";
 "id_card_face" = "http://123.56.237.91/uploadfiles/2016/05/201605271350035741.jpg";
 "id_card_hand" = "http://123.56.237.91/uploadfiles/2016/05/201605271350349627.jpg";
 qq = 512867796;
 "second_audit_remarks" = "";
 "second_audit_status" = 1;
 "second_audit_time" = "1970-01-01";
 "true_name" = "\U5b8b\U6606\U9e4f";
 uid = 1;
 */
@property (nonatomic,copy)NSString *alipay;
@property (nonatomic,copy)NSString *bank;
@property (nonatomic,copy)NSString *bank_card;
@property (nonatomic,copy)NSString *cash_deposit;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *id_card;
@property (nonatomic,copy)NSString *id_card_back;
@property (nonatomic,copy)NSString *id_card_face;
@property (nonatomic,copy)NSString *id_card_hand;
@property (nonatomic,copy)NSString *qq;
@property (nonatomic,copy)NSString *second_audit_remarks;
@property (nonatomic,copy)NSString *second_audit_status;
@property (nonatomic,copy)NSString *second_audit_time;
@property (nonatomic,copy)NSString *true_name;

@end
