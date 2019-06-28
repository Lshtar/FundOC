//
//  UIColor+HXFNSStringTool.h
//  HeXinFund
//
//  Created by D on 2018/5/3.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HXFNSStringTool)

/**
 * 通过给定的颜色字符串生成指定的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexadecimal;


@end
