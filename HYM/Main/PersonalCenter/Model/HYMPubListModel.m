//
//  HYMPubListModel.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPubListModel.h"

@implementation HYMPubListModel

- (void)setAttributes:(NSDictionary *)dic{

    self.map = @{@"id":@"taskID"};
    [super setAttributes:dic];
}
@end
