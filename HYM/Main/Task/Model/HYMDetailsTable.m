//
//  HYMDetailsTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/5.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMDetailsTable.h"
#import "HYMIntroduceCell.h"
#import "HYMCourseCell.h"
@interface HYMDetailsTable ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HYMDetailsTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";

    HYMIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    HYMCourseCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.section == 0) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYMIntroduceCell" owner:self options:nil] lastObject];
        return cell;
    }else{
    
        cell2 = [[[NSBundle mainBundle] loadNibNamed:@"HYMCourseCell" owner:self options:nil] lastObject];
        return cell2;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        return 200;
    }

    return 170;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 0.001;
    }
    
    return 10;
}
@end
