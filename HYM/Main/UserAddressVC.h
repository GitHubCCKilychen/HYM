//
//  UserAddressListVC.h
//  PingChuan
//
//  Created by pengli on 15/10/12.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "PullRefreshTVCGrouped.h"
@protocol SaveAddressInfoDelegate;
@interface UserAddressVC : PullRefreshTVCGrouped
@property (nonatomic, assign) id <SaveAddressInfoDelegate> delegate;
@end
@protocol SaveAddressInfoDelegate <NSObject>
@optional
-(void)saveAddressInfo:(NSDictionary *)info;
@end
