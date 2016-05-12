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

- (void)setFanliArr:(NSArray *)fanliArr{

    _fanliArr = fanliArr;
    
    NSLog(@"%ld",(unsigned long)_fanliArr.count);
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

//    //此处做判断
//    switch (self.index) {
//        case 0:
//            return self.listArr.count;
//            break;
//        case 1:
//            return self.fanliArr.count;
//            break;
//        default:
//            break;
//    }
    

    return self.listArr.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    HYMTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[HYMTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else{
    
        while ([cell.contentView.subviews lastObject] != nil) {
            
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }

        
    }
    [cell cell2];
    HYMTaskModel *model = self.listArr[indexPath.row];
    cell.model = model;
    switch (self.index) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
           
        }
            break;
        default:
            break;
    }

        
    
    

   
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
    [self.viewController.navigationController pushViewController:taskDetailsVC animated:YES];
    
}
@end
