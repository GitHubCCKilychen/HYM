//
//  HYMSearchTableVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSearchTableVC.h"
#import "HYMSearchResurtVC.h"
@interface HYMSearchTableVC ()<UISearchResultsUpdating>

@property (nonatomic,strong)UISearchController *seacrchVC;
@property (nonatomic,strong)NSMutableArray *datalist;
@end

@implementation HYMSearchTableVC

-  (UISearchController *)seacrchVC{

    if (_seacrchVC == nil) {
        HYMSearchResurtVC *searchResurt = [[HYMSearchResurtVC alloc] init];
        _seacrchVC = [[UISearchController alloc] initWithSearchResultsController:searchResurt];
        _seacrchVC.searchBar.frame = CGRectMake(0, 0, kScreenWitdth, 40);
        _seacrchVC.searchBar.placeholder = @"请输入搜索内容";

}
return _seacrchVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    NSArray *array = @[@"james", @"viola", @"nolan", @"messi", @"melody", @"lynn", @"kim", @"wilson", @"kevin", @"louis", @"yuki", @"scott", @"simba"];
    self.datalist = [NSMutableArray arrayWithArray:array];
    
    //注册自定义单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.tableHeaderView = self.seacrchVC.searchBar;
}


/**
    更新
 */
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    //创建临时数组，存放搜索内容
    NSMutableArray *tempArr = [NSMutableArray array];
    //搜索内容
    NSString *text = searchController.searchBar.text;
    //遍历内容
    for (NSString *name in self.datalist) {
        
        //  1、text不能为空，第二判断contact是否包括字符串text，是得话，加入到临时数组中
        if ([text length] != 0 && [name containsString:text]) {
            
            [tempArr addObject:name];
        }
    }
    
    // 给searchResultsViewController进行传值，并且reloadData
    HYMSearchResurtVC *search = (HYMSearchResurtVC *)searchController.searchResultsController;
    [search.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.datalist count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    cell.textLabel.text = [self.datalist objectAtIndex:indexPath.row];
    
    return cell;
    
}

@end
