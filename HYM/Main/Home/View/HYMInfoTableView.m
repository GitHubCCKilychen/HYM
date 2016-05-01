//
//  HYMInfoTableView.m
//  今日资讯
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInfoTableView.h"
#import "HYMInfoCell.h"
#import "HYMBlogVC.h"
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


- (void)setCount:(NSArray *)count{

    _count = count;
    
}

- (void)setIndex:(NSInteger)index{

    _index = index;
    
    [self reloadData];
    
    NSLog(@"--%ld",(long)_index);
}

- (void)setCount2:(NSArray *)count2{

    _count2 = count2;
//    NSLog(@"----%ld",(unsigned long)_count2.count);
    [self reloadData];
}
#pragma mark tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_index == 1) {
        
         NSLog(@"----%ld",(unsigned long)_count2.count);
        return _count2.count;
    }
    
   
    return _count.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString *identifier = @"cell";
    HYMInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[HYMInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    if (_index == 1) {
        
        cell.model = self.count2[indexPath.row];
    }else{
    
        cell.model = self.count[indexPath.row];
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
    
        blogVC.title = @"网贷资讯";
        blogVC.view.backgroundColor = [UIColor whiteColor];
        [self.viewController.navigationController pushViewController:blogVC animated:YES];
    
    }else if (_index == 1){
    
        blogVC.title = @"银行资讯";
        blogVC.view.backgroundColor = [UIColor whiteColor];
        [self.viewController.navigationController pushViewController:blogVC animated:YES];
    }
    
    
}



@end
