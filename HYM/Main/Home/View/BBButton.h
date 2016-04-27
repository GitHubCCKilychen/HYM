//
//  BBButton.h
//  BiaoBiao
//
//  Created by 平川嘉恒 on 14-1-3.
//  Copyright (c) 2014年 平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBButton : UIButton
@property(nonatomic,copy)NSString *btnId;
@property(nonatomic,assign)NSInteger btnRow;
@property(nonatomic,assign)NSInteger btnSection;
@end
