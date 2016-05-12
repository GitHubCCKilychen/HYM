//
//  HYMTaskBottom.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMTaskBottom : UIView
@property (weak, nonatomic) IBOutlet UIImageView *forwardImage;//转发
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;//评论
@property (weak, nonatomic) IBOutlet UIImageView *zan;//点赞

- (IBAction)forwardBtn:(UIButton *)sender;
- (IBAction)commentBtn:(UIButton *)sender;
- (IBAction)zanBtn:(UIButton *)sender;
@end
