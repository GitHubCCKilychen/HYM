//
//  HYMSeletTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/19.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSeletTable.h"

@interface  HYMSeletTable ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
@property (nonatomic,strong)UISearchController *search;

@property (nonatomic,strong)NSMutableArray *searchList;
@property (nonatomic,strong)NSMutableArray *datalist;
@property (nonatomic,weak)UITableViewCell *cell;
@property (nonatomic,strong)NSMutableArray *headList;
@end
@implementation HYMSeletTable

- (UISearchController *)search{
    
    if (_search == nil) {
        
        _search = [[UISearchController alloc] initWithSearchResultsController:nil];
        _search.searchBar.frame = CGRectMake(0, 0, kScreenWitdth, 44);
        _search.delegate = self;
        _search.searchResultsUpdater = self;
        _search.dimsBackgroundDuringPresentation = NO;
        _search.obscuresBackgroundDuringPresentation = NO;
//        _search.hidesNavigationBarDuringPresentation = NO;
    }
    return _search;
}

- (NSMutableArray *)searchList{

    if (_searchList == nil) {
        
        _searchList = [NSMutableArray array];
    }
    return _searchList;
}

- (NSMutableArray *)headList{

    if (_headList== nil) {
        
        _headList =[NSMutableArray arrayWithObjects:@"1", nil];
    }
    return _headList;
}
- (NSMutableArray *)datalist{

    if (_datalist == nil) {
        
        _datalist = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    
    }
    return _datalist;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{


    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.tableHeaderView = self.search.searchBar;

    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.search.active) {
        
        return [self.searchList count];
    }
    
    if (section == 0) {
        
        return 1;
    }else if (section == 1){
    
        return 1;
    }

    
    return [self.datalist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *string = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        
        if (indexPath.section == 1) {
            
            for (int i = 0; i < 4; i++) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(10+i*(kScreenWitdth-20-15)/4+i*5, 7, (kScreenWitdth-20-15)/4, 30);
                btn.backgroundColor = [UIColor grayColor];
                
                [cell.contentView addSubview:btn];
            }
           
        }else if(indexPath.section == 0){
        
           
            for (int i = 0; i < self.headList.count; i++) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(10+i*(kScreenWitdth-20-15)/4+i*5, 7, (kScreenWitdth-20-15)/4, 30);
                btn.backgroundColor = [UIColor grayColor];
                
                [cell.contentView addSubview:btn];
            }
        }else{
        
            UIImageView *imageView = [[UIImageView  alloc] init];
            imageView.frame = CGRectMake(10, 7, (kScreenWitdth-20-15)/4, 30);
            imageView.backgroundColor = [UIColor brownColor];
            [cell.contentView addSubview:imageView];
            
            UILabel *title = [[UILabel alloc]init];
            title.frame = CGRectMake(10+imageView.frame.size.width+10, 7, 80, 20);
            title.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:title];
            
        }
    }
    
    
    
    self.cell = cell;
    
    
    
   
    if (self.search.active) {
        
        cell.textLabel.text = self.searchList[indexPath.row];
    }else{
    
        
        NSArray *arr = self.datalist[indexPath.section];
//        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return @"你选过的平台";
    }else if (section == 1){
    
        return @"最近热门的平台";
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 2) {
        return 10;
    }
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //点击后设置当前第0组的数据显示是是选择的
    if (indexPath.section == 0) {
       
        self.cell.textLabel.text = self.search.searchBar.text;
  
    }
    
    
}
#pragma mark 搜索数据过滤
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    NSString *searchString = [self.search.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.datalist filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self reloadData];
}
@end
