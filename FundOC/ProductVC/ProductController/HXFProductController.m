//
//  HXFProductController.m
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFProductController.h"

@interface HXFProductController ()

@end

@implementation HXFProductController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"产品";
     self.view.backgroundColor = [UIColor purpleColor];
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
