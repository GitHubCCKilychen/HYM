//
//  HYMUpHeader.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/10.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMUpHeader.h"
#import "HYMPublishVC.h"
@implementation HYMUpHeader

- (UIButton *)addPic{

    if (_addPic == nil) {
        
        _addPic = [UIButton buttonWithType:UIButtonTypeCustom];
        _addPic.backgroundColor = [UIColor brownColor];
        [_addPic addTarget:self action:@selector(addTaskAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPic;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor grayColor];
        [self initWithView];
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.addPic];
    
    self.addPic.sd_layout
    .leftSpaceToView(self,60).bottomSpaceToView(self,20)
    .topSpaceToView(self,20).rightSpaceToView(self,60);
    
}

- (void)addTaskAct:(UIButton *)task{
    
    HYMPublishVC *upTask = [[HYMPublishVC alloc] init];
    [self.viewController.navigationController pushViewController:upTask animated:YES];
}
@end
