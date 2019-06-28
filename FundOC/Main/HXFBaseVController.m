//
//  HXFBaseVController.m
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFBaseVController.h"

@interface HXFBaseVController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
    
@property (nonatomic, copy) navigationLeftbarBlock leftBlock;
@property (nonatomic, copy) navigationRightbarBlock rightBlock;
@property (nonatomic, copy) errorPageReloadBlock reloadBlock;

@end

@implementation HXFBaseVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self currentVCSupportLeftGesture:NO];
    //
    [self addOtherMethods];
}
    
- (void)setNavTitle:(NSString *)title
{
    self.navigationItem.title = title;
    self.navigationController.navigationBar.hidden = NO;
}
    
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    hideLoadingView;
}
    
- (void)addLeftBarButtonImage:(UIImage *)image title:(NSString *)title block:(navigationLeftbarBlock)block
{
    self.leftBlock = block;
    //
    CGFloat width = hxf_ScreenWidth/4.0;
    CGFloat height = 44;
    UIView *customView = [[UIView alloc]init];
    [customView setFrame:CGRectMake(0, 0, width, height)];
    customView.backgroundColor = [UIColor clearColor];
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setBackgroundColor:[UIColor clearColor]];
    [clearButton setFrame:CGRectMake(0, 0, width, height)];
    [clearButton addTarget:self action:@selector(barButtonLeftClickAction) forControlEvents:UIControlEventTouchUpInside];
    //
    if(title.length > 0)
    {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        [label setFrame:CGRectMake(20, 11, customView.frame.size.width-20, 20)];
        label.textColor = HEF_COLOR_HEX(@"32333C");
        label.text = title;
        label.font = [UIFont systemFontOfSize:15.0];
        label.textAlignment = NSTextAlignmentLeft;
        [customView addSubview:label];
        //
        [customView addSubview:clearButton];
    }
    else if(image)
    {
        UIImageView *imageV = [[UIImageView alloc]init];
        [imageV setFrame:CGRectMake(20, 11, 11, 20)];
        imageV.image = image;
        [customView addSubview:imageV];
        //
        [customView addSubview:clearButton];
    }
    else
    {
        //都传空就不再显示左侧控件
    }
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    //
    self.navigationController.navigationBar.hidden = NO;
}
- (void)addRightBarButtonImage:(UIImage *)image title:(NSString *)title block:(navigationRightbarBlock)block
{
    self.rightBlock = block;
    //
    CGFloat width = hxf_ScreenWidth/4.0;
    CGFloat height = 44;
    UIView *customView = [[UIView alloc]init];
    [customView setFrame:CGRectMake(0, 0, width, height)];
    customView.backgroundColor = [UIColor clearColor];
    //
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setBackgroundColor:[UIColor clearColor]];
    [clearButton setFrame:CGRectMake(0, 0, width, height)];
    [clearButton addTarget:self action:@selector(barButtonRightClickAction) forControlEvents:UIControlEventTouchUpInside];
    //
    CGFloat rightSide = 20;
    if(title.length > 0)
    {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = HEF_COLOR_HEX(@"32333C");
        [label setFrame:CGRectMake(0, 11, customView.frame.size.width-rightSide, 20)];
        label.text = title;
        label.font = [UIFont systemFontOfSize:15.0];
        label.textAlignment = NSTextAlignmentRight;
        [customView addSubview:label];
        //
        [customView addSubview:clearButton];
    }
    else
    {
        UIImageView *imageV = [[UIImageView alloc]init];
        [imageV setFrame:CGRectMake(customView.frame.size.width-rightSide-17, 11, 17, 17)];
        imageV.image = image;
        [customView addSubview:imageV];
        //
        [customView addSubview:clearButton];
    }
    //
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    //
    self.navigationController.navigationBar.hidden = NO;
}
    
- (void)barButtonLeftClickAction
{
    self.leftBlock();
}
    
- (void)barButtonRightClickAction
{
    self.rightBlock();
}
    
- (void)logInAction
{
//    HXFLoginViewController *vc = [[HXFLoginViewController alloc]init];
//    vc.fromWhere = 2;
//    [self.navigationController pushViewController:vc animated:YES];
}
    
//使用系统的navigation。下面的横线默认是不显示的。为了让横线显示。加了方法
- (void)showNavigationLineAction
{
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"navigationLine"];
}
    
//创建统一的网络请求错误页面(block是点击重新加载按钮的方法回调)
- (void)showNetWorkErrorPage:(errorPageReloadBlock)block
{
    self.reloadBlock = block;
    //
    UIView *errorPageView = [[UIView alloc]init];
    [errorPageView setFrame:CGRectMake(0,Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar)];
    errorPageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:errorPageView];
    //
    UIImageView *reloadImageV = [[UIImageView alloc]init];
    reloadImageV.image = [UIImage imageNamed:@"errorPage_errorIcon"];
    [reloadImageV setFrame:CGRectMake(0, 88, 172, 168)];
    [reloadImageV setCenterX:errorPageView.centerX];
    [errorPageView addSubview:reloadImageV];
    //
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"网络不给力，请检查你的网络！";
    label.textColor = HEF_COLOR_HEX(@"999AA6");
    label.font = [UIFont systemFontOfSize:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFrame:CGRectMake(0, reloadImageV.frame.origin.y+reloadImageV.frame.size.height+15, errorPageView.frame.size.width, 20)];
    [errorPageView addSubview:label];
    //
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadBtn setFrame:CGRectMake((hxf_ScreenWidth-70)/2.0, label.frame.origin.y+label.frame.size.height+23, 100, 28)];
    [reloadBtn setBackgroundColor:[UIColor clearColor]];
    [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [reloadBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [reloadBtn setTitleColor:HEF_COLOR_HEX(@"5287FF") forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(reloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    [errorPageView addSubview:reloadBtn];
    reloadBtn.centerX = errorPageView.centerX;
}
    
//创建统一的网络请求错误页面(block是点击重新加载按钮的方法回调)
- (void)showNetWorkErrorPageSuperView:(UIView *)superView block:(errorPageReloadBlock)block
{
    self.reloadBlock = block;
    //
    UIView *errorPageView = [[UIView alloc]init];
    [errorPageView setFrame:CGRectMake(0,Height_NavBar, superView.frame.size.width, superView.frame.size.height-Height_NavBar)];
    errorPageView.backgroundColor = [UIColor whiteColor];
    [superView addSubview:errorPageView];
    //
    UIImageView *reloadImageV = [[UIImageView alloc]init];
    reloadImageV.image = [UIImage imageNamed:@"errorPage_errorIcon"];
    [reloadImageV setFrame:CGRectMake(0, 88, 172, 168)];
    [reloadImageV setCenterX:errorPageView.centerX];
    [errorPageView addSubview:reloadImageV];
    //
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"网络不给力，请检查你的网络！";
    label.textColor = HEF_COLOR_HEX(@"999AA6");
    label.font = [UIFont systemFontOfSize:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFrame:CGRectMake(0, reloadImageV.frame.origin.y+reloadImageV.frame.size.height+15, errorPageView.frame.size.width, 20)];
    [errorPageView addSubview:label];
    //
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadBtn setFrame:CGRectMake((hxf_ScreenWidth-70)/2.0, label.frame.origin.y+label.frame.size.height+23, 100, 28)];
    [reloadBtn setBackgroundColor:[UIColor clearColor]];
    [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [reloadBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [reloadBtn setTitleColor:HEF_COLOR_HEX(@"5287FF") forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(reloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    [errorPageView addSubview:reloadBtn];
    reloadBtn.centerX = errorPageView.centerX;
}

- (void)haveCustomedNaviShowNetWorkErrorPage:(errorPageReloadBlock)block
{
    //
    self.reloadBlock = block;
    UIView *errorPageView = [[UIView alloc]init];
    [errorPageView setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    errorPageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:errorPageView];
    //
    UIImageView *reloadImageV = [[UIImageView alloc]init];
    reloadImageV.image = [UIImage imageNamed:@"errorPage_errorIcon"];
    [reloadImageV setFrame:CGRectMake(0, 88, 172, 168)];
    [reloadImageV setCenterX:errorPageView.centerX];
    [errorPageView addSubview:reloadImageV];
    //
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"网络不给力，请检查你的网络！";
    label.textColor = HEF_COLOR_HEX(@"999AA6");
    label.font = [UIFont systemFontOfSize:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFrame:CGRectMake(0, reloadImageV.frame.origin.y+reloadImageV.frame.size.height+15, errorPageView.frame.size.width, 20)];
    [errorPageView addSubview:label];
    //
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadBtn setFrame:CGRectMake((hxf_ScreenWidth-70)/2.0, label.frame.origin.y+label.frame.size.height+23, 100, 28)];
    [reloadBtn setBackgroundColor:[UIColor clearColor]];
    [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [reloadBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [reloadBtn setTitleColor:HEF_COLOR_HEX(@"5287FF") forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(reloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    [errorPageView addSubview:reloadBtn];
    reloadBtn.centerX = errorPageView.centerX;
}

- (void)reloadButtonAction:(UIButton *)button
{
    UIView *buttonSuperView = [button superview];
    [buttonSuperView removeFromSuperview];
    self.reloadBlock();
}
    
- (void)jumpBarBarIndex:(NSInteger)index
{
    if(index>2)
    {
        index=0;
    }
    [self.tabBarController setSelectedIndex:index];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
    
//一个气泡请求的方法展示全局气泡
- (void)showFullPopViewWithIdentify:(NSString *)identify
{
//    WeakSelf
//    showLoading
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:identify,@"code", nil];
//    HXFAirBubblesRequest *request = [HXFAirBubblesRequest requestWithParameters:param];
//    [[HXFRequestManager sharedManager] sendRequest:request completionHandler:^(BOOL success, NSString *code, NSString *message, NSDictionary *data, NSError *error) {
//        hideLoadingView
//        [weakSelf callRequestWithSuccess:success code:code message:message data:data error:error];
//    }];
    
}
    
- (void)callRequestWithSuccess:(BOOL)success code:(NSString *)code message:(NSString *)message data:(NSDictionary *)data error:(NSError *)error
{
//    if(success)
//    {
//        HXFAirBubbleModel *model = [HXFAirBubbleModel yy_modelWithDictionary:data];
//        NSString *title = model.title;
//        NSString *content = model.context;
//        [[HXFFullPopView sharedInstance] showFullPopViewTitle:title content:content];
//    }
//    else
//    {
//        showToast(message)
//    }
}
    
    //无数据页面
- (void)showNoDataPageWithFrame:(CGRect)frame title:(NSString *)title superView:(UIView *)superView
{
    UIView *tempView = [[UIView alloc]init];
    [tempView setBackgroundColor:[UIColor clearColor]];
    [tempView setFrame:frame];
    [superView addSubview:tempView];
    //
    CGSize size = CGSizeMake(161.0, 178.0);
    UIImageView *iconImage = [[UIImageView alloc]init];
    iconImage.image = [UIImage imageNamed:@"emptyPage_emptyIcon"];
    [iconImage setFrame:CGRectMake(0, 60, size.width, size.height)];
    [tempView addSubview:iconImage];
    //
    UILabel *label = [[UILabel alloc]init];
    [label setFrame:CGRectMake(0, iconImage.frame.origin.y+iconImage.frame.size.height+20, tempView.frame.size.width, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = HEF_COLOR_HEX(@"999AA6");
    label.font = [UIFont systemFontOfSize:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    [tempView addSubview:label];
    label.text = title;
    //
    iconImage.centerX = tempView.frame.size.width/2.0;
    label.centerX = tempView.frame.size.width/2.0;
}
    
#pragma mark -- 左滑手势 -- start
    
- (void)currentVCSupportLeftGesture:(BOOL)support
{
    if(support)
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    else
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
    
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(self.navigationController.childViewControllers.count==1)
    {
        return NO;
    }
    return YES;
}

- (void)getMainQueue:(void (^)())block
{
    dispatch_async(dispatch_get_main_queue(), block);
}
#pragma mark -- 左滑手势 -- end
    
#pragma mark -- 当前网络是否可用
    //当前网络是否可用
- (BOOL)currentNetWorkIsAvailable
{
//    HXFReachability *reach = [HXFReachability reachabilityForInternetConnection];
//    NetworkStatus status = [reach currentReachabilityStatus];
    if([netwrok_error_code isEqualToString:@"999"])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
    
//解决scrolview下沉问题
- (void)addOtherMethods
{
    if (@available(iOS 11.0, *)){
            //nothing
    }
    else
    {
        @try {
            self.automaticallyAdjustsScrollViewInsets = NO;
        } @catch (NSException *exception) {
                
        } @finally {
                
        }
            
    }
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
