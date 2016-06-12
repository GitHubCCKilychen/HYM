//
//  OrderDetailVC.h
//  PingChuan
//
//  Created by LarryRodic on 15/3/25.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "AllVC.h"

@interface OrderDetailVC : AllVC
@property(nonatomic,copy)NSString *keytype;
@property(nonatomic,copy)NSString *blogId;
@property(nonatomic,assign)BOOL isCartOrBuy;
@end