//
//  HYMTask2Deatail.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMTask2Deatail : UITableViewCell<UIWebViewDelegate>

@property (nonatomic,strong)UIActivityIndicatorView *activityView;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *activity;
@property (nonatomic,strong)UILabel *activityContent;//活动内容
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)UIButton *btn;
@end
