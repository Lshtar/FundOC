//
//  UIColor+HXFTool.h
//  HeXinFund
//
//  Created by D on 2018/5/3.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HXFTool)

/**
 * 十六进制颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 * 随机颜色
 */
+(UIColor *)randomColor;

/**
 * RGB颜色
 */
+ (UIColor *)colorWithWholeRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;


@end
