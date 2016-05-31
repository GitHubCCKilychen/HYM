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
        [_addPic setImage:[UIImage imageNamed:@"添加任务"] forState:UIControlStateNormal];
//        [_addPic setTitle:@"上传任务" forState:UIControlStateNormal];

        [_addPic addTarget:self action:@selector(addTaskAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPic;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:234/255.f green:234/255.f blue:236/255.f alpha:1];
        [self initWithView];
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.addPic];
    
    self.addPic.sd_layout
    .leftSpaceToView(self,60).topSpaceToView(self,20)
    .rightSpaceToView(self,60).heightIs(70);
    
}

- (void)addTaskAct:(UIButton *)task{
    
    HYMPublishVC *upTask = [[HYMPublishVC alloc] init];
    [self.viewController.navigationController pushViewController:upTask animated:YES];
}


@end
