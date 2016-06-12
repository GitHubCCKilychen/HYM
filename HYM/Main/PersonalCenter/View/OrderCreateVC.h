//
//  OrderCreateVC.h
//  PingChuan
//
//  Created by pengli on 15/10/12.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "AllVC.h"

@interface OrderCreateVC : AllVC

@property (nonatomic, assign) BOOL isReality;
@property (nonatomic, retain) NSMutableArray * dataSource;
@property (nonatomic, copy) NSString * keytype;
@property (nonatomic, copy) NSString * keyid;
@property (nonatomic, assign) NSInteger sectionNum;
@property (nonatomic, assign) NSInteger buycount;
@end
