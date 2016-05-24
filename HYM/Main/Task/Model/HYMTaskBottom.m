//
//  HYMTaskBottom.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskBottom.h"
#import "HYMCommentVC.h"
@interface HYMTaskBottom ()


@end

@implementation HYMTaskBottom



- (IBAction)forwardBtn:(UIButton *)sender {
}
- (IBAction)commentBtn:(UIButton *)sender {
    
    HYMCommentVC *comment = [[HYMCommentVC alloc] init];
    comment.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:comment animated:YES];
    
    
}
- (IBAction)zanBtn:(UIButton *)sender {
    
    if (sender.selected == NO) {
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       
        sender.selected = YES;
    }else if (sender.selected == YES){

            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
        sender.selected = NO;
    }
    
    
}
@end
