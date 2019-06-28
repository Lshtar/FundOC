//
//  UIColor+HXFTool.m
//  HeXinFund
//
//  Created by D on 2018/5/3.
//  Copyright © 2018年 D. All rights reserved.
//

#import "UIColor+HXFTool.h"

@implementation UIColor (HXFTool)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [UIColor colorWithHexString:color alpha:1.f];
}

+(UIColor *)randomColor
{
    CGFloat red = arc4random()%255/255.0f;
    CGFloat green = arc4random()%255/255.0f;
    CGFloat blue = arc4random()%255/255.0f;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    return color;
}

+ (UIColor *)colorWithWholeRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
}


@end
