//
//  HYMInLastView.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMConModel.h"
@interface HYMInLastView : UIView

@property (nonatomic,strong)HYMConModel *model;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *returnMoney;
@property (nonatomic,strong)UILabel *money;
@property (nonatomic,strong)UIButton *makeMoney;
@property (nonatomic,strong)UIView *invitationView;
@property (nonatomic,strong)UILabel *continueInvite;//继续邀请

@property (nonatomic,strong)NSArray *income;//提成
@property (nonatomic,weak)UILabel *content;//内容
@end
