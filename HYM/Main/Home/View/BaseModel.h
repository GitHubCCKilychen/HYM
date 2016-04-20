//
//  BaseModel.h
//  Project02-微博
//
//  Created by Mac on 15-10-18.
//  Copyright (c) 2015年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject


-(id)initWithDictionary:(NSDictionary*)dic;
-(void)setAttributes:(NSDictionary*)dic;

@property (nonatomic,copy) NSDictionary*map;

- (NSString *)getString:(NSString *)soucre;
@end
