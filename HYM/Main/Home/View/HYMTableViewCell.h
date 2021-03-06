//
//  HYMTableViewCell.h
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMInfoCellModel.h"
#import "HYMTaskModel.h"
#import "HYMCenMallModel.h"
@interface HYMTableViewCell : UITableViewCell

@property (nonatomic,assign)NSIndexPath *indexPath;
@property (nonatomic,strong)NSArray *btnTitleArr;
@property (nonatomic,assign)NSInteger index;


/**
 *  @param storeImage 商品图片
 *  @param title 标题
 *  @param subTitle 副标题
 *  @param timeImage 钟表图片、
 *  @param timeEnd 截止时间
 *  @param peopleCount 参数人数
 */

@property (nonatomic,strong)HYMTaskModel *taskModel;
//@property (nonatomic,strong)UIButton *hotBtn;
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *title;
//@property (nonatomic,strong)UILabel *subTitle;
@property (nonatomic,strong)UIImageView *timeImage;
@property (nonatomic,strong)UILabel *timeEnd;//截止时间
@property (nonatomic,strong)UILabel *peopleCount;//参与人数
@property (nonatomic,strong)UIImageView *peopleImage;//参与人数
@property (nonatomic,strong)UIButton *ignoreBtn;//忽略
@property (nonatomic,strong)UIButton *notInvolved;//未参与

/**
 *  @param titleInforation 今日资讯标题
 *  @param subImage 图片
 *  @param rightImage 右侧图片
 *  @param source 来源
 *  @param comment 评论
 */
@property (nonatomic,strong)HYMInfoCellModel *model;
@property (nonatomic,strong)UILabel *titleInforation;//今日资讯标题
@property (nonatomic,strong)UILabel *time;
@property (nonatomic,strong)UIImageView *leftImageView;
@property (nonatomic,strong)UILabel *comment;//评论


/**
 *  羊毛商城
 */
@property (nonatomic,strong)HYMCenMallModel *mallModel;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *topBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIButton *centerBtn;


- (void)initCell1;
- (void)initCell2;
- (void)initCell3;
@end
