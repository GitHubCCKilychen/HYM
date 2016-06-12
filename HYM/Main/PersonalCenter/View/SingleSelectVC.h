//
//  SingleSelectVC.h
//  PingChuan
//
//  Created by LarryRodic on 15/3/19.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllVC.h"

@protocol SingleSelectDelegate;
@interface SingleSelectVC : AllVC
@property(nonatomic,assign)NSObject<SingleSelectDelegate>* delegate;
@property(nonatomic,retain)NSMutableArray *dataSource;
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,copy)NSString *parentid;//父类id
@property(nonatomic,copy)NSString *keyName;//key值
@property(nonatomic,copy)NSString *firstId;//初始的id
@property(nonatomic,copy)NSString *firstName;//初始的name
@property(nonatomic,assign)NSInteger keyType;//类型 0 城市地区选择返回 1 三级地区的选择
@end

//返回时调用
@protocol SingleSelectDelegate <NSObject>
@required

@optional
-(void)SingleSelectOK:(NSMutableDictionary*)backDic parentid:(NSString*)parentid keyName:(NSString*)keyName;
-(void)SingleSelectNumber:(NSInteger)myNumber;
@end