//
//  HYMTaskModel.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskModel.h"

@implementation HYMTaskModel

- (void)setAttributes:(NSDictionary *)dic{
    
    self.map = @{@"id":@"taskID:"};
    
    [super setAttributes:dic];
}
@end
