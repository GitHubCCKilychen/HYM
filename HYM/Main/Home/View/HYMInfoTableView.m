//
//  HYMInfoTableView.m
//  今日资讯
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInfoTableView.h"
#import "HYMBlogVC.h"
#import "HYMTodayInfoModel.h"
#import "HYMInfoCell.h"
@interface HYMInfoTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HYMInfoTableView

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
//        self.backgroundColor = [UIColor grayColor];
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        
    }
    
    return self;
}

- (void)setButtonIndex:(NSInteger)buttonIndex{

    _buttonIndex = buttonIndex;
//    NSLog(@"%ld",(long)_buttonIndex);
}

#pragma mark 数据
- (void)setInfoArr:(NSMutableArray *)infoArr{


    _infoArr = infoArr;
    [self reloadData];

}
- (void)setBankArr:(NSMutableArray *)bankArr{

    _bankArr = bankArr;
    [self reloadData];
}
#pragma mark tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.buttonIndex == 0) {
        
        return _infoArr.count;
    }
    
    
    
    return _bankArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString *identifier = @"cell";
    HYMInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[HYMInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
       
        
    }
    if (self.buttonIndex == 0) {
        
        HYMTodayInfoModel *model = self.infoArr
        [indexPath.row];
        
        cell.model = model;
    }else if(self.buttonIndex ==1){
        
        HYMTodayInfoModel *model = self.bankArr[indexPath.row];
        
        cell.model = model;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110.f;
}

#pragma mark 事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //1.判断当前的按钮
    //2.根据按钮跳转不同界面
    
    HYMBlogVC *blogVC = [[HYMBlogVC alloc] init];

    if (_index == 0) {
    
        [self.viewController.navigationController pushViewController:blogVC animated:YES];
    
    }else if (_index == 1){
    
        [self.viewController.navigationController pushViewController:blogVC animated:YES];
    }
    
    
}

@end
