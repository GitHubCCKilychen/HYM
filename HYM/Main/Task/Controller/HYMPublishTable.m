//
//  HYMPublishTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishTable.h"
#import "HYMPublishCell.h"
@interface HYMPublishTable ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HYMPublishTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    HYMPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HYMPublishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.indexPath = indexPath;
        
        if (indexPath.row == 2) {
            
            CGFloat btnX = ((kScreenWitdth-60)/2);
            CGFloat btnWidth = (kScreenWitdth-60)/2;
            
            NSArray *title = @[@"马上参与",@"马上报单"];
            
            for (int i = 0; i < 2; i++) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(20+20*i+i*btnX, 15, btnWidth, 40);
                btn.backgroundColor = [UIColor orangeColor];
                
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.tag = i;
                [btn setTitle:title[i] forState:UIControlStateNormal];
                btn.layer.cornerRadius = 5;
                btn.titleLabel.font = [UIFont systemFontOfSize:15];
                
                [self  addSubview:btn];
                
                if (i == 1) {
                    
                    btn.backgroundColor = [UIColor lightGrayColor];
                }
                
                [cell.contentView addSubview:btn];
                
                
            }
            
        }
        

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.row == 2) {
        
        return 65;
    }
    
    
    return 110;
}


@end
