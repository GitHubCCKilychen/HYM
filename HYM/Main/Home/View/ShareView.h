//
//  ShareView.h
//  分享－－
//
//  Created by 刘晓雪 on 16/4/22.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ShareView : UIView

+ (instancetype)shareViewWithPresentedViewController:(UIViewController *)controller items:(NSArray *)items title:(NSString *)title image:(UIImage *)image urlResource:(NSString *)url;
@end
