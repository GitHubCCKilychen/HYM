//
//  PullRefreshTableViewController.h
//  Plancast
//
//  Created by Leah Culver on 7/2/10.
//  Copyright (c) 2010 Leah Culver
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>
//#import "GlobalString.h"


@interface PullRefreshTVCGrouped : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UILabel *refreshTime;//更新时间
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    
    BOOL isMore;//加载更多
    UIView *footerView;
    UIView *footerViewNoData;
    UILabel *labNoData;
    UILabel *labelNoData;
    UILabel *addmoreLab;
    UIActivityIndicatorView *addmoreSpinner;
    UIButton *btnNoData;
    UIView *noDataView;//无数据时显示的view
    
    
    UITableView *mytable;
}

@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
@property (nonatomic,retain)UITableView *mytable;
@property (nonatomic, retain) UILabel * noDataLab;//无数据时显示的文字

@property(nonatomic,retain)UIImageView *noImgView;

- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;

-(void)startAddMore;
-(void)addMore;
-(void)stopAddMore;
-(void)getNoMoreData;

-(void)showNoDataView:(NSString*)str;
-(void)showNoDataImg:(NSString*)str;
-(void)hideNoDataView;

- (void)reSetTableViewFrame:(CGRect)newFrame;
- (void)forbidAddMore;//禁止加载更多
- (void)canAddMore;//可以加载更多
@end
