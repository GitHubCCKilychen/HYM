//
//  HYMBlogVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMBlogVC.h"
#import "HYMBottomView.h"
@interface HYMBlogVC ()
@property (nonatomic,strong)HYMBottomView *bottomView;
@end

@implementation HYMBlogVC
- (HYMBottomView *)bottomView{
    
    if (_bottomView == nil) {
        
        _bottomView = [[HYMBottomView alloc] init];
        _bottomView.frame = CGRectMake(0, self.view.frame.size.height-400, self.view.frame.size.width, 49);
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithView];
}

- (void)initWithView{
    
    
    [self.view addSubview:self.bottomView];
}


@end
