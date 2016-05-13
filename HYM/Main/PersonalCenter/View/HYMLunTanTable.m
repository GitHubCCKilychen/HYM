//
//  HYMLunTanTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMLunTanTable.h"
#import "HYMLunTanCell.h"
@interface HYMLunTanTable ()<UITableViewDataSource,UITableViewDelegate >

@end
@implementation HYMLunTanTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    
    HYMLunTanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[HYMLunTanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return (kScreenHeight-114)/3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}
@end
