//
//  CategoryVC.h
//  PingChuan
//
//  Created by pengli on 15/9/21.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "PullRefreshTVCGrouped.h"

@interface CategoryVC : PullRefreshTVCGrouped

@property (nonatomic, copy) NSString * keytype;
@property (nonatomic, assign) NSInteger isFirst;
@property (nonatomic, assign) NSInteger isSecond;
@property (nonatomic, copy) NSString * keyid;
@property (nonatomic, copy) NSString * sellerid;
@property (nonatomic, copy) NSString * searchKey;
@property (nonatomic, copy) NSString * typeName;
@property (nonatomic, assign) BOOL isShiWu;

@end
