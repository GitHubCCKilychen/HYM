//
//  HYMHeaderView.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"
@interface HYMInHeaderView : UIView
/**
 *
 */
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *content;//内容
@property (nonatomic,strong)ScrollView *scrollView;

@end
