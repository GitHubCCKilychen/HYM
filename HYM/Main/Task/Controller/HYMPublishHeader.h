//
//  HYMPublishHeader.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMPublishHeader : UIView

@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIImageView *timeImage;
@property (nonatomic,strong)UILabel *timeEnd;//截止时间
@property (nonatomic,strong)UILabel *peopleCount;//参与人数
@property (nonatomic,strong)UIImageView *peopleImage;//人数图片
@property (nonatomic,strong)UIButton *chatBtn;//咨询
@property (nonatomic,strong)UIImageView *announcerImage;//发布者图片
@property (nonatomic,strong)UILabel *announcer;//发布者
@end
