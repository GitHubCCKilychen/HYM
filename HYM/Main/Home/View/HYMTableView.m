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
#import "HYMInfoCellModel.h"
#import "HYMTaskModel.h"
#import "HYMInformationVC.h"
#import "HYMCenMallModel.h"
#import "HYMMallView.h"
@interface HYMTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)HYMMallView *mallView;
@end
@implementation HYMTableView


#pragma mark 分组个数
- (void)setInfoArr:(NSMutableArray *)infoArr{
    _infoArr = infoArr;
    

    
}


- (void)setTaskArr:(NSMutableArray *)taskArr{

    _taskArr = taskArr;
    
}

- (void)setMallArr:(NSMutableArray *)mallArr{

    _mallArr = mallArr;


    
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
    
    if (section == 0) { return self.taskArr.count;
        
    }else if(section == 1){ return 1;
    
    }
    
    return self.infoArr.count;


}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    HYMTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    
    if (!cell) {
        
        cell = [[HYMTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
    }
    else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.indexPath = indexPath;
    if (indexPath.section == 0) {
        
        [cell initCell1];
        
        HYMTaskModel *taskModel = self.taskArr[indexPath.row];
        
        cell.taskModel = taskModel;
        
    }else if (indexPath.section == 1){
        
        self.mallView = [[HYMMallView alloc] init];
        self.mallView.frame = CGRectMake(0, 0, kScreenWitdth,150);
        
        HYMCenMallModel *model = self.mallArr[indexPath.row];
        self.mallView.model = model;
        
        [cell.contentView addSubview:self.mallView];
      
    }else{
    
        [cell initCell3];
        
        HYMInfoCellModel *model = self.infoArr[indexPath.row];
        
        cell.model = model;
        
    }

    
    
    return cell;
    
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

   
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        
            return 110;

    }else if (indexPath.section == 2){
    
     
        return 110.f;
    }
        return 150.f;
}

//#pragma mark 组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    HYMSectionHeader *header = [[HYMSectionHeader alloc] init];
    header.index = section;
    header.backgroundColor = [UIColor whiteColor];
    header.section = section;
    return header;
}

#pragma mark 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //点击任务精选

    if (indexPath.section == 0) {
        
        [self.viewController.tabBarController setSelectedIndex:1];
        
    }else if (indexPath.section == 2){
        
        //今日资讯
        HYMInformationVC *infoVC = [[HYMInformationVC alloc] init];
        [self.viewController.navigationController pushViewController:infoVC animated:YES];
        
    }
}

@end
