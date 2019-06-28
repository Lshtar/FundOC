//
//  UITextField+ExtentRange.h
//  HeXinFound
//
//  Created by D on 2018/9/18.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)

//获取焦点的位置
-(NSRange)selectedRange;
//设置焦点的位置
-(void)setSelectedRange:(NSRange)range;

@end
