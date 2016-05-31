//
//  PostPublishNewVC.h
//  PingChuan
//
//  Created by pengli on 16/1/12.
//  Copyright © 2016年 平川嘉恒. All rights reserved.
//

#import "AllVC.h"

@interface PostPublishNewVC : AllVC
@property (nonatomic, assign) NSInteger keytype;
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, retain) NSMutableDictionary * dataSource;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, copy) NSString * keyid;
@property (nonatomic, assign) BOOL isCopy;
@end
