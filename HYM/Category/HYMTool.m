//
//  HYMTool.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTool.h"

@implementation HYMTool


//label常用方法
//label常用方法
+ (UILabel *)initLabel:(UILabel *)label withFont:(UIFont *)textFont withTextColor:(UIColor *)textColor withTextAlignment:(NSTextAlignment *)textAlignment{

    label.font = textFont;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    return label;
}
#pragma mark 时间转换
+(NSString *)internalFromCreatTime:(NSString *)creatTimeString formatString:(NSString *)formatString
{
    //创建对应的日期格式化
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatString ? formatString:@"yyyy-MM-dd HH:mm:ss"];
    //生成对应格式的日期对象
    NSString *dateString=[[self class]userfulStringForDateFormat:creatTimeString];
    //    NSLog(@"-----------%@",creatTimeString);
    NSDate *currentDate=[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate new]]];
    
    
    NSDate *createDate=[dateFormatter dateFromString:dateString];
    
    //计算日期间隔
    NSTimeInterval timeInterval= [currentDate timeIntervalSinceDate:createDate];
    //    NSLog(@"==========%f",timeInterval);
    double days = timeInterval/(3600.0*24);
    double hours = timeInterval/(3600.0);
    double minutes = timeInterval/(60.0);
    //    NSLog(@"minutes=%f",minutes);
    if (days > 7) {
        //        NSLog(@"---------");
        return [dateString substringToIndex:19];
    } else if (days >= 1) {
        return [NSString stringWithFormat:@"%d天前", (int)days];
    } else if (hours >= 1) {
        return [NSString stringWithFormat:@"%d小时前", (int)hours];
    } else {
        return [NSString stringWithFormat:@"%d分钟前", (int)minutes];
    }
    return nil;
}
+(NSString *)userfulStringForDateFormat:(NSString *)aString
{
    //将类如@“2015-02-04T10：53：30+08：00”这样的格式的时间字符串替换成“2015-02-04 10：53：30”这种格式的字符串
    return  [[aString stringByReplacingOccurrencesOfString:@"T" withString:@" "]stringByReplacingOccurrencesOfString:@"+08:00" withString:@""];
    
    
    
}

//获取主appdelegate
+ (AppDelegate*)xfuncGetAppdelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

+ (XtomManager*)xfuncGetXtomManager
{
    return [XtomManager sharedManager];
}
@end
