//
//  HXFTabBar.m
//  HeXinFund
//
//  Created by D on 2018/5/3.
//  Copyright © 2018年 D. All rights reserved.
//

#import "HXFTabBar.h"
#import "UIView+HXFExtension.h"

static const NSInteger ITEMCOUNT = 3;

@interface HXFTabBar ()

@property (nonatomic, strong) UIButton *orderButton;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation HXFTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, [UIScreen mainScreen].bounds.size.width, 1)];
        topView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:topView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor greenColor]];
        
        //[button setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        button.bounds = CGRectMake(0, 0, 64, 64);
        self.centerBtn = button;
        [self addSubview:button];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // self.height * 0.2
    self.centerBtn.center = CGPointMake(self.width * 0.5, self.height * 0.1);
    
    int index = 0;
    CGFloat wigth = self.width / ITEMCOUNT;
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            sub.x = index * wigth;
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.centerBtn];
        
        if ( [self.centerBtn pointInside:newPoint withEvent:event]) {
            return self.centerBtn;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        return [super hitTest:point withEvent:event];
    }
}

@end
