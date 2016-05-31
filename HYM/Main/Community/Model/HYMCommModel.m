//
//  HYMCommModel.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommModel.h"

@implementation HYMCommModel

- (void)setAttributes:(NSDictionary *)dic{
    
    self.map = @{@"id":@"blogID"};
    [super setAttributes: dic];
}
@end
