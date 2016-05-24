//
//  HYMSystemSetting.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSystemSetting.h"
#import "HYMSettingTable.h"

@interface HYMSystemSetting ()

@property (nonatomic,strong)HYMSettingTable *table;
@end

@implementation HYMSystemSetting

-(HYMSettingTable *)table{

    if (_table == nil) {
        
        _table = [[HYMSettingTable alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, kScreenHeight)];
    }
    return _table;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initDefault];
    [self initView];
}

- (void)initDefault{

    self.title = @"设置";
    self.view.backgroundColor = BB_Back_Color_Here;
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)initView{

    [self.view addSubview:self.table];

}
@end
