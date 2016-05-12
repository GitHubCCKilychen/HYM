//
//  HYMPersonTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPersonTable.h"
#import "HYMPushSingleCell.h"
#import "HYMTMyInvolvementCell.h"
#define textColor [UIColor colorWithRed:251/256.f green:149/256.f blue:89/256.f alpha:1]
@interface HYMPersonTable ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HYMPersonTable


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
     
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }
   

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    
    HYMPushSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    HYMTMyInvolvementCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (indexPath.section == 0) {
        
        cell = [[HYMPushSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        NSArray *titleArr = @[@"推单店铺",@"购物中心"];
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(28, 8, 100, 20);
        title.text = titleArr[indexPath.row];
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:15] withTextColor:textColor withTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:title];
        
        if (indexPath.row == 0) {
            
//            [cell initCell1];//
            
            //此处做个判断是否已经登录--如果登录移除上面的cell
            [cell loginBtn];
        }else{
        
            [cell initCell2];
        }
        
        return cell;
    }else{
    
        cell2 = [[HYMTMyInvolvementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        return cell2;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return 185/2;
    }else{
    
        return 100;
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return 10;
    }
    return 0.001;
}
@end
