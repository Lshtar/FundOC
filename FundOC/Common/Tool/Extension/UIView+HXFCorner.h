//
//  UIView+HXFCorner.h
//  HeXinFound
//
//  Created by lishaopeng on 2018/6/6.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXFCorner)
//设置某一个或两个角为圆角
- (void)setViewCornerRadius:(CGFloat)cornerRadius
                       type:(UIRectCorner)corners;

@end
