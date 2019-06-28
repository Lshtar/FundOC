//
//  HXFBaseVController.h
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^navigationLeftbarBlock)();
typedef void(^navigationRightbarBlock)();
typedef void(^errorPageReloadBlock)();

@interface HXFBaseVController : UIViewController
//设置标题
@property (nonatomic, strong) NSString *navTitle;
//定义左侧按钮的显示方式。图片或者文字只传一种。block内写回掉方法(都传空就不再显示左侧控件)
- (void)addLeftBarButtonImage:(UIImage *)image title:(NSString *)title block:(navigationLeftbarBlock)block;
//定义右侧按钮的显示方式。图片或者文字只传一种。block内写回掉方法
- (void)addRightBarButtonImage:(UIImage *)image title:(NSString *)title block:(navigationRightbarBlock)block;
//跳转登录页面
- (void)logInAction;
//使用系统的navigation。下面的横线默认是不显示的。为了让横线显示。加了方法
- (void)showNavigationLineAction;
//创建统一的网络请求错误页面(block是点击重新加载按钮的方法回调)
- (void)showNetWorkErrorPage:(errorPageReloadBlock)block;
//创建统一的网络请求错误页面(block是点击重新加载按钮的方法回调)
- (void)showNetWorkErrorPageSuperView:(UIView *)superView block:(errorPageReloadBlock)block;
//创建统一的网络请求错误页面(block是点击重新加载按钮的方法回调,有系统navigationBar)
- (void)haveCustomedNaviShowNetWorkErrorPage:(errorPageReloadBlock)block;
//index 只能是0,1,2
- (void)jumpBarBarIndex:(NSInteger)index;
//一个气泡请求的方法展示全局气泡
- (void)showFullPopViewWithIdentify:(NSString *)identify;
//无数据页面
- (void)showNoDataPageWithFrame:(CGRect)frame title:(NSString *)title superView:(UIView *)superView;
//是否支持左滑手势（默认是不支持的）
- (void)currentVCSupportLeftGesture:(BOOL)support;
// 获取主线程
- (void)getMainQueue:(void (^)())block;
//当前网络是否可用
- (BOOL)currentNetWorkIsAvailable;
    
@end

NS_ASSUME_NONNULL_END
