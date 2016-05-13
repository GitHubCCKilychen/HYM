//
//  HYMGoTaskCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMGoTaskCell : UITableViewCell

@property (nonatomic,assign)NSInteger selection;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *activity;
@property (nonatomic,strong)UILabel *activityContent;//活动内容
@property (nonatomic,strong)NSArray *btnTitle;
@property (nonatomic,strong)NSArray *btnTitleStop;
@end
