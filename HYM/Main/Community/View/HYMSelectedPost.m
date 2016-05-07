//
//  HYMSelectedPost.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSelectedPost.h"
#import "HYMPostTable.h"
@interface HYMSelectedPost ()

@property (nonatomic,strong)HYMPostTable *tableView;

@end
@implementation HYMSelectedPost

- (HYMPostTable *)tableView{

    if (_tableView == nil) {
        _tableView = [[HYMPostTable alloc] initWithFrame:CGRectMake(70, 64, kScreenWitdth- 70, kScreenHeight - 64)];

        
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    
        self.backgroundColor = [UIColor clearColor];
        
        [self initWithView];
    }
    
    return self;
}

- (void)initWithView{
    
    [self addSubview:self.tableView];
    
    
}
@end
