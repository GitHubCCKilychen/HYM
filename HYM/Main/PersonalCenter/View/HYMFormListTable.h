//
//  HYMFormListTable.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMFormListTable : UITableView
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *cardNum;//身份
@property (nonatomic,strong)NSString *apply;//支付宝
@property (nonatomic,strong)NSString *bandNum;//银行卡号
@property (nonatomic,strong)NSString *cardAddress;
@property (nonatomic,strong)NSString *qqEmails;//邮箱
@property (nonatomic,strong)NSString *qq;
@property (nonatomic,strong)NSString *phoneNum;

@property (nonatomic,strong)NSString *photo1;
@property (nonatomic,strong)NSString *photo2;
@property (nonatomic,strong)NSString *photo3;

@end
