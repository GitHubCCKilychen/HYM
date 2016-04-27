//
//  StoreDetailVC.h
//  PingChuan
//
//  Created by pengli on 15/9/25.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "PullRefreshTVCGrouped.h"

@protocol operateCollectDelegate <NSObject>

- (void)operateSuccess;

@end

@interface StoreDetailVC : PullRefreshTVCGrouped

@property (nonatomic, copy) NSString * keyid;
@property (nonatomic, assign) BOOL isShiWu;
@property (nonatomic, assign) BOOL isPresent;
@property (nonatomic, assign) id<operateCollectDelegate> delegate;

@end
