//
//  HYMStoreTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMStoreTable.h"

@interface HYMStoreTable ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HYMStoreTable

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame: frame]) {
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
}


@end
