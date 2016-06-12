//
//  changPasswordVC.h
//  BAOWEN
//
//  Created by 李朋 on 13-10-14.
//  Copyright (c) 2013年 平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Navbar.h"
#import "AllVC.h"

@interface ChangPasswordVC : AllVC<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)BOOL isZhiFu;
@property(nonatomic,assign)BOOL isFirst;
@end
