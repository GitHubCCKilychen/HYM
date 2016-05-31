//
//  HYMUpModel.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMUpModel.h"

@implementation HYMUpModel

- (void)setAttributes:(NSDictionary *)dic{

    self.map = @{@"id":@"taskID"};
    [super setAttributes: dic];
}
@end
