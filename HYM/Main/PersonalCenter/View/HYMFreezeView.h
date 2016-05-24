//
//  HYMFreezeView.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMSortView.h"
@interface HYMFreezeView : UIView

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIImageView *lineImage;
@property (nonatomic,strong)UILabel *list;
@property (nonatomic,strong)HYMSortView *sortView;
@end
