//
//  HYMCourseCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/5.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCourseCell.h"

@implementation HYMCourseCell

//nib加载
- (void)awakeFromNib {
  
    self.line.layer.cornerRadius = 4;
    self.line.layer.masksToBounds = YES;
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backView.layer.borderWidth = 1;
    
}


- (IBAction)textTask:(UIButton *)sender {
}

- (IBAction)photoTask:(UIButton *)sender {
}
- (IBAction)textAct:(UIButton *)sender {
}

- (IBAction)photoAct:(UIButton *)sender {
}
@end
