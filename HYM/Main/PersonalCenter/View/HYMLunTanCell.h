//
//  HYMLunTanCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMLunTanCell : UITableViewCell


@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UILabel *time;
@property (nonatomic,strong)UILabel *connent;//内容
@property (nonatomic,strong)UILabel *connentTitle;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIButton *tagTitle;//标签
@property (nonatomic,strong)UIButton *readBtn;//阅读
@property (nonatomic,strong)UIButton *commentBtn;//评论
@property (nonatomic,strong)UIButton *zanBtn;
@end
