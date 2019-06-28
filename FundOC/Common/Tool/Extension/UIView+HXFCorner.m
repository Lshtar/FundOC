//
//  UIView+HXFCorner.m
//  HeXinFound
//
//  Created by lishaopeng on 2018/6/6.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import "UIView+HXFCorner.h"

@implementation UIView (HXFCorner)

- (void)setViewCornerRadius:(CGFloat)cornerRadius
                       type:(UIRectCorner)corners
{
    CGSize radii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    
    shapeLayer.frame = self.bounds;
    
    shapeLayer.path = maskPath.CGPath;
    
    self.layer.mask = shapeLayer;
}

@end
