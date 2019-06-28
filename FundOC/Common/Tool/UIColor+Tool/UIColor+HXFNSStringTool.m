//
//  UIColor+HXFNSStringTool.m
//  HeXinFund
//
//  Created by D on 2018/5/3.
//  Copyright © 2018年 D. All rights reserved.
//

#import "UIColor+HXFNSStringTool.h"

@implementation UIColor (HXFNSStringTool)

/**
 * 通过给定的颜色字符串生成指定的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexadecimal
{
    const char *cString = [hexadecimal cStringUsingEncoding: NSASCIIStringEncoding];
    long int hex;
    
    if (cString[0] == '#')
    {
        hex = strtol(cString + 1, NULL, 16);
    }
    else
    {
        hex = strtol(cString, NULL, 16);
    }
    
    return [[self class] colorWithHex: (UInt32)hex];
}

+ (UIColor *)colorWithHex:(UInt32)hexadecimal
{
    CGFloat red, green, blue;
    
    red = (hexadecimal >> 16) & 0xFF;
    green = (hexadecimal >> 8) & 0xFF;
    blue = hexadecimal & 0xFF;
    
    return [UIColor colorWithRed: red / 255.0f green: green / 255.0f blue: blue / 255.0f alpha: 1.0f];
}


@end
