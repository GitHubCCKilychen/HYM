//
//  BBButton.m
//  BiaoBiao
//
//  Created by 平川嘉恒 on 14-1-3.
//  Copyright (c) 2014年 平川嘉恒. All rights reserved.
//

#import "BBButton.h"
//#import "EmitterView.h"

@implementation BBButton
@synthesize btnId;
@synthesize btnRow;
@synthesize btnSection;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}
- (void)dealloc
{
    [btnId release];btnId = nil;
    [super dealloc];
}

@end
