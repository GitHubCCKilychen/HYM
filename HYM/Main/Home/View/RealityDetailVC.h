//
//  RealityDetailVC.h
//  PingChuan
//
//  Created by pengli on 15/9/23.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "PullRefreshTVCGrouped.h"

@interface RealityDetailVC : PullRefreshTVCGrouped

@property (nonatomic, assign) BOOL isPresent;
@property (nonatomic, copy) NSString * keytype;
@property (nonatomic, assign) BOOL isOutdate;
@property (nonatomic, copy) NSString * keyid;
@property (nonatomic, assign) BOOL isSetting;

@end
