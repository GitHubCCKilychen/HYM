//
//  HYMUpTaskCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/10.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMUpTaskCell.h"

@implementation HYMUpTaskCell

- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
        _lineView.frame = CGRectMake(kScreenWitdth/2-0.5, 10, 1, 15);
    }
    return _lineView;
}

- (UIImageView *)storeImage{

    if (_storeImage == nil) {
        
        _storeImage = [[UIImageView alloc] init];
        
    }
    return _storeImage;
}

- (UILabel *)connect{

    if (_connect == nil) {
        
        _connect = [[UILabel alloc] init];
        _connect.numberOfLines = 0;
        _connect.font = [UIFont systemFontOfSize:14];
    }
    return _connect;
}

- (UIButton *)editBtn{

    if (_editBtn == nil) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editAct:  ) forControlEvents:UIControlEventTouchUpInside];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _editBtn.backgroundColor = [UIColor colorWithRed:45/255.f green:156/255.f blue:253/255.f alpha:1];
    }
    
        return _editBtn;
}

- (UIButton *)deleteBtn{

    if (_deleteBtn == nil) {
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAct:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _deleteBtn.backgroundColor = [UIColor colorWithRed:184/255.f green:186/255.f blue:187/255.f alpha:1];
    }
    return _deleteBtn;
}
- (void)setModel:(HYMUpModel *)model{

    _model = model;
    
    [_storeImage sd_setImageWithURL:[NSURL URLWithString:_model.logo]];
    self.connect.text = _model.title;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{


        [self initWithView];
}


- (void)initWithView{
    
    
    
    [self.contentView addSubview:self.storeImage];
    [self.contentView addSubview:self.connect];
    [self.contentView addSubview:self.editBtn];
    [self.contentView addSubview:self.deleteBtn];
    
    self.storeImage.backgroundColor = [UIColor grayColor];
    self.storeImage.sd_layout
    .leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10).widthIs(60);
    
//    self.connect.backgroundColor = [UIColor brownColor];
    self.connect.sd_layout
    .leftSpaceToView(self.storeImage,10).topEqualToView(self.storeImage)
    .widthRatioToView(self.contentView,0.5).heightIs(50);
    
//    self.editBtn.backgroundColor = [UIColor grayColor];
    self.editBtn.sd_layout
    .leftSpaceToView(self.connect,10).topEqualToView(self.storeImage)
    .rightSpaceToView(self.contentView,10).heightIs(25);
    
//    self.deleteBtn.backgroundColor = [UIColor brownColor];
    self.deleteBtn.sd_layout
    .leftEqualToView(self.editBtn).rightEqualToView(self.editBtn)
    .topSpaceToView(self.editBtn,8).heightIs(25);
}

#pragma mark 任务删除
- (void)deleteAct:(UIButton *)btn{

    //调用接口
    NSDictionary *dic = @{@"taskid":@"11",@"token":@"1"};
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_del" target:self selector:@selector(loadData:) parameter:dics];
    
}
- (void)loadData:(NSDictionary *)dic{

    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
}

#pragma mark 编辑任务
- (void)editAct:(UIButton *)btn{

    //调用编辑接口
    
}
@end
