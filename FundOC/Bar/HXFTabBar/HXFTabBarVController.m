//
//  HXFTabBarVController.m
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFTabBarVController.h"
#import "HXFNavigationVController.h"
#import "HXFHomeController.h"
#import "HXFProductController.h"
#import "HXFPropertyController.h"
#import "HXFMineController.h"

#define HomeString        @"首页"
#define ProductString     @"产品"
#define PropertyString    @"资产"
#define MineString        @"我的"

@interface HXFTabBarVController ()<UITabBarControllerDelegate>
    
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation HXFTabBarVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
    [self setupChildVc:[[HXFHomeController alloc] init] title:HomeString image:@"tabBar_wode_click" selectedImage:@"tabBar_wode_click" isHiddenNavgationBar:YES];
    [self setupChildVc:[[HXFProductController alloc] init] title:ProductString  image:@"tabBar_wode_click" selectedImage:@"tabBar_wode_click" isHiddenNavgationBar:YES];
    [self setupChildVc:[[HXFPropertyController alloc] init] title:PropertyString image:@"tabBar_wode_click" selectedImage:@"tabBar_wode_click" isHiddenNavgationBar:YES];
    [self setupChildVc:[[HXFMineController alloc] init] title:MineString image:@"tabBar_wode_click" selectedImage:@"tabBar_wode_click" isHiddenNavgationBar:YES];
    //
    self.currentIndex = 0;
    
    //    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:HEF_COLOR_LIGHTGRAY]];
    //  设置tabbar
    //    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    // 设置自定义的tabbar
    //[self setCustomtabbar];
}

#pragma mark - 设置自定义中心按钮
/*
 - (void)setCustomtabbar
 {
 HXFTabBar *tabbar = [[HXFTabBar alloc]init];
 [self setValue:tabbar forKeyPath:@"tabBar"];
 [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
 }
 
 - (void)centerBtnClick:(UIButton *)btn
 {
 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你点击了订单按钮" preferredStyle:UIAlertControllerStyleAlert];
 [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
 [self presentViewController:alert animated:YES completion:nil];
 }
 */
    
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage isHiddenNavgationBar:(BOOL)isHidden
{
    static NSInteger index = 0;
    //vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.tag = index;
    index++;
    
    HXFNavigationVController *nav = [[HXFNavigationVController alloc]initWithRootViewController:vc];
    nav.navigationBar.hidden = isHidden;
    [self addChildViewController:nav];
}
    
// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
    
+ (void)initialize
{
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs[NSForegroundColorAttributeName] = HEF_COLOR_HEX(@"8b9ba3");
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selectedAttrs[NSForegroundColorAttributeName] = HEF_COLOR_HEX(@"eb5252");
        
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
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
