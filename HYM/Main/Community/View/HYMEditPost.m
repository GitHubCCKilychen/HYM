//
//  HYMEditPost.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMEditPost.h"
#import "HYMEditCell.h"
#import "HYMTieziVC.h"
@interface HYMEditPost ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HYMEditPost

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        
        [self initView];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    HYMEditCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"帖子分类";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
        }else if(indexPath.row == 1){
        
            UITextField *textField = [[UITextField alloc] init];
            textField.frame = CGRectMake(15, 0, cell.contentView.frame.size.width, 44);
            
            textField.placeholder = @"标题(最多36字符";
            textField.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:textField];

        }else if (indexPath.row == 2){
            cell2 = [[HYMEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell2;
        }
        
       
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 2) {
        
        return kScreenHeight-44;
    }
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        HYMTieziVC *tieziVC = [[HYMTieziVC alloc] init];
        [self.viewController.navigationController pushViewController:tieziVC animated:YES];
        
    }
}

- (void)initView{

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(100, kScreenHeight-80, 40, 20);
    view.backgroundColor = [UIColor greenColor];
    
    [self.viewController.view addSubview:view];
}
@end
