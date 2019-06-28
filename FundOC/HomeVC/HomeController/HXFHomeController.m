//
//  HXFHomeController.m
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFHomeController.h"

@interface HXFHomeController ()

@property(nonatomic, strong) UIView *naviBar;

@end

@implementation HXFHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = [UIColor redColor];
}

- (UIView *)naviBar {
    if (_naviBar == nil) {
        CGFloat px = hxf_ScreenWidth/750.0f;
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hxf_ScreenWidth, Height_NavBar)];
        _naviBar.backgroundColor = [UIColor whiteColor];
        _naviBar.layer.shadowOffset = CGSizeMake(0, 2 * px);
        _naviBar.layer.shadowColor  = [UIColor blackColor].CGColor;
        _naviBar.layer.shadowRadius = 11 * px;
        _naviBar.layer.shadowOpacity = 0.08;
        _naviBar.alpha = 0;
        _naviBar.alpha = 0;
    }
    return _naviBar;
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
