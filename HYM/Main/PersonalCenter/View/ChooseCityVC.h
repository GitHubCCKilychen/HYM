//
//  ChooseCityVC.h
//  PingChuan
//
//  Created by LarryRodic on 14-10-23.
//  Copyright (c) 2014年 平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllVC.h"
#import "XtomConst.h"
#import "BBButton.h"

@protocol BackChooseCityGetDelegate;
@interface ChooseCityVC : AllVC<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property(nonatomic,copy)NSString *currentCity;
@property(nonatomic,assign)NSObject<BackChooseCityGetDelegate>*delegate;
@end

@protocol BackChooseCityGetDelegate <NSObject>
-(void)backWithChooseCity;
@end