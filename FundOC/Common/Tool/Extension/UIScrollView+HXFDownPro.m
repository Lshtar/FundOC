//
//  UIScrollView+HXFDownPro.m
//  HeXinFound
//
//  Created by lishaopeng on 2018/7/13.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import "UIScrollView+HXFDownPro.h"

@implementation UIScrollView (HXFDownPro)

+ (void)load {
    
    @try {
        if (@available(iOS 11.0, *)){
            
            [[self appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
            
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
@end
