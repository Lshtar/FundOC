//
//  HXFNavigationVController.m
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFNavigationVController.h"

@interface HXFNavigationVController ()<UIGestureRecognizerDelegate>

@end

@implementation HXFNavigationVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //解决自定义返回按钮后滑动手势失效的问题
    //禁止侧滑
    //    self.interactivePopGestureRecognizer.delegate = self;
    
}
    
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}
    
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [[UITabBar appearance] setTranslucent:NO];
    }
    //这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    //解决iPhone X push页面时 tabBar上移的问题
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
