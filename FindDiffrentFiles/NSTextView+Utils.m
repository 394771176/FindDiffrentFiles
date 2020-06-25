//
//  NSTextView+Utils.m
//  QuestionCompareTools
//
//  Created by cheng on 2017/10/27.
//  Copyright © 2017年 cheng. All rights reserved.
//

#import "NSTextView+Utils.h"

@implementation NSTextView (Utils)

- (void)addLog:(NSString *)log
{
    NSString *str = self.string;
    if (str.length) {
        [self setString:[str stringByAppendingFormat:@"\n%@", log]];
    } else {
        [self setString:log ?: @""];
    }
}

@end
