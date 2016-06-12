//
//  RefundVC.h
//  PingChuan
//
//  Created by pengli on 15/11/10.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "AllVC.h"

@interface RefundVC : AllVC

@property (nonatomic, retain) NSMutableDictionary * dataSource;
@property (nonatomic, copy) NSString * shipping_name;
@property (nonatomic, copy) NSString * shipping_num;
@property (nonatomic, assign) BOOL isSend;

@end
