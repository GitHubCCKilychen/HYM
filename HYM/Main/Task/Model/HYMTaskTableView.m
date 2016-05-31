//
//  HYMTaskTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskTableView.h"
#import "HYMTaskCell.h"
#import "HYMTaskListModel.h"
#import "HYMTaskDetailsVC.h"
#import "HYMTaskModel.h"

@interface HYMTaskTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HYMTaskTableView


- (void)setListArr:(NSMutableArray *)listArr{

    
    _listArr = listArr;


}

- (void)setFanliArr:(NSMutableArray *)fanliArr{

    _fanliArr = fanliArr;

}

- (void)setIndex:(NSInteger)index{

    _index = index;

 
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
    }
    
    return self;
}



#pragma mark datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


     return self.fanliArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    HYMTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[HYMTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
         [cell cell2];
       
    }
//    else{
//    
//        while ([cell.contentView.subviews lastObject] != nil) {
//            
//            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//
//        
//    }
    

    
        HYMTaskModel *model = self.fanliArr[indexPath.row];
        
        cell.model = model;

    

    
   
    return cell;
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 110.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

#pragma mark 跳转任务详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HYMTaskDetailsVC *taskDetailsVC = [[HYMTaskDetailsVC alloc] init];
    taskDetailsVC.index = indexPath.row;
    [self.viewController.navigationController pushViewController:taskDetailsVC animated:YES];
    
    if (self.index == 2) {
        
        taskDetailsVC.newIndex = 2;
    }
    

    
}
@end
