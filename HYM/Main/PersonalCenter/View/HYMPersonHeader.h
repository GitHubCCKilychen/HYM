//
//  HYMPersonHeader.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMPersonHeader : UIView

@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UIImageView *sexImage;
@property (nonatomic,strong)UILabel *invitationCode;
@property (nonatomic,strong)UIButton *nextBtn;//下一个
@property (nonatomic,strong)UIImageView *leftImage;
@property (nonatomic,strong)UIImageView *rightImage;
@property (nonatomic,strong)UILabel *money;
@property (nonatomic,strong)UILabel *moneyTitle;
@property (nonatomic,strong)UILabel *frozenGold;//冻结金额
@property (nonatomic,strong)UIButton *seeDetails;//查看详情

@end
