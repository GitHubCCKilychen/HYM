//
//  HYMTableView.m
//  首页
//
//  Created by 刘晓雪 on 16/4/15.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTableView.h"
#import "HYMTableViewCell.h"
#import "HYMSectionHeader.h"
@interface HYMTableView ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation HYMTableView


#pragma mark 分组个数
- (void)setSectionArr:(NSArray *)sectionArr{

    _sectionArr = sectionArr;
}

#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        //头视图
    }
    
    return self;
}



#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) { return 3;
        
    }else if(section == 1){ return 1;
    
    }else if(section == 2) { return 5;
    
    }

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *identifier = [NSString stringWithFormat:@"cell%d_%d",indexPath.section,indexPath.row];
    //解决方式1
    
    
    HYMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[HYMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.indexPath = indexPath;
    
    return cell;
    
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        
        return 10;
    }else if (section == 1)
    {
    
        return 10;
    }
    
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return 110;
    }else if (indexPath.section == 2){
    
        //此处修改
        return 110;
    }
    
    return 160.f;
}

#pragma mark 组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HYMSectionHeader *header = [[HYMSectionHeader alloc] init];
    header.backgroundColor = [UIColor whiteColor];
    header.section = section;
    return header;
    
}


@end
