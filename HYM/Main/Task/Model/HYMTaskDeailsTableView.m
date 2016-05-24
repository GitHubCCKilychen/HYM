//
//  HYMTaskDeailsTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskDeailsTableView.h"

#import "HYMTaskDeailsCell.h"
#import "HYMTask2Deatail.h"
#import "HYMTaskRecord.h"
#import "HYMJoinView.h"
#import "HYMCommentVC.h"
#import "HYMFormVC.h"
@interface HYMTaskDeailsTableView ()<UITableViewDataSource,UITableViewDelegate,HYMCommentDelagete>

@property (nonatomic,weak)HYMTask2Deatail *cell1;
@property (nonatomic,assign)int indexCount;


@end
@implementation HYMTaskDeailsTableView



#pragma mark 
- (void)setDatalist:(NSMutableArray *)datalist{
    
 

    _datalist = datalist;
}


- (void)setIndex:(NSInteger)index{

    _index = index;
    
    
}


- (void)setNewIndex:(NSInteger)newIndex{

    _newIndex = newIndex;
    
    
}
#pragma mark 协议
- (void)comment:(NSString *)text with:(int)indexCount{


    self.indexCount = indexCount;
   
    [self reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self == [super initWithFrame:frame style:style]) {
     
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;

       
        
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 3;
    }
    
    return self.indexCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    HYMTaskDeailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    HYMTask2Deatail *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (indexPath.section == 1) {
        
        cell = [[HYMTaskDeailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        return cell;
    }else if (indexPath.section ==0 ){
    
        cell1  = [[HYMTask2Deatail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell1.indexPath = indexPath;
        self.cell1 = cell1;
        if (indexPath.row == 2) {
            
            CGFloat btnX = ((kScreenWitdth-60)/2);
            CGFloat btnWidth = (kScreenWitdth-60)/2;
            
            NSArray *title = @[@"马上参与",@"马上报单"];
            
            NSArray *titleNew = @[@"马上参与",@"记账"];
            
            for (int i = 0; i < 2; i++) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(20+20*i+i*btnX, 15, btnWidth, 40);
                btn.backgroundColor = [UIColor orangeColor];
                
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.tag = i;
                btn.layer.cornerRadius = 5;
                btn.titleLabel.font = [UIFont systemFontOfSize:15];
                
                [self  addSubview:btn];
                
                if (i == 1) {
                    
                    btn.backgroundColor = [UIColor lightGrayColor];
                }
                if (self.newIndex == 2) {
                    
                    [btn setTitle:titleNew[i] forState:UIControlStateNormal];
                }else{
    
                    [btn setTitle:title[i] forState:UIControlStateNormal];
    
                }
                
                [cell1.contentView addSubview:btn];
                
                
            }
            
         
            
           
            UIButton *btn = [cell1.contentView viewWithTag:1];
            [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell1;
    }
    
    return cell;
}

#pragma mark delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 55;
    }
   

    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 250;
    }

    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        
        if (indexPath.row == 2) {
            
            return 65;
        }
        return 110;
    }
    
    
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

  
    
    if (section == 0) {
        HYMJoinView *view = [[HYMJoinView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:241/255.f green:242/255.f blue:242/255.f alpha:1];
        view.frame = CGRectMake(0, 0, kScreenWitdth, 55);
        
        
        HYMTaskDetailModel *model = self.datalist[section];
        view.model = model;
        
        
        return view;
        
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        
        HYMTaskRecord *record = [[HYMTaskRecord alloc] init];
        record.index = (int)self.index;
        record.newIndex = self.newIndex;
        record.frame = CGRectMake(0, 0, kScreenWitdth, 250);
        record.backgroundColor = [UIColor whiteColor];
        
         return  record;
    }
    
    
    
    return nil;
}
#pragma mark 展开事件
- (void)btnAct:(UIButton *)btn{

    
//    NSLog(@"234");
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, kScreenWitdth, 50);
    view.backgroundColor = [UIColor grayColor];

 
    if (self.cell1.indexPath.section == 1) {
        
    
    }
    if (btn.tag == 1) {
        
        HYMFormVC *formVC = [[HYMFormVC alloc] init];
        formVC.hidesBottomBarWhenPushed = YES;
        formVC.index = (int)self.index;
        [self.viewController.navigationController pushViewController:formVC animated:YES];
    }
}

@end
