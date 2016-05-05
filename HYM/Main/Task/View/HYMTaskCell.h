//
//  HYMTaskCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMTaskCell : UITableViewCell

/**
 *  @param storeImage 商品图片
 *  @param title 标题
 *  @param subTitle 副标题
 *  @param timeImage 钟表图片、
 *  @param timeEnd 截止时间
 *  @param peopleCount 参数人数
 */

@property (nonatomic,strong)UIButton *hotBtn;
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *title;
//@property (nonatomic,strong)UILabel *subTitle;
@property (nonatomic,strong)UIImageView *timeImage;
@property (nonatomic,strong)UILabel *timeEnd;//截止时间
@property (nonatomic,strong)UILabel *peopleCount;//参与人数
@property (nonatomic,strong)UIImageView *peopleImage;//参与人数
@property (nonatomic,strong)UIButton *ignoreBtn;//忽略
@property (nonatomic,strong)UIButton *notInvolved;

/**
 *  组1
 */
@property (nonatomic,strong)UIImageView *moneyImage;
@property (nonatomic,strong)UILabel *cellOneTitle;

- (void)cell1;
- (void)cell2;
@end
