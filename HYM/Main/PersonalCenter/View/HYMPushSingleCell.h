//
//  HYMPushSingleCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMPushSingleCell : UITableViewCell

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UILabel *connetTitle;
@property (nonatomic,strong)UILabel *connect;
@property (nonatomic,strong)UIButton *detailBtn;
@property (nonatomic,strong)UIButton *rightBtn;
- (void)initCell1;
- (void)initCell2;

//登录之后，
- (void)loginBtn;
@end
