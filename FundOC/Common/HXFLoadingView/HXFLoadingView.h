//
//  HXFLoadingView.h
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXFLoadingView : UIView
    
@property (nonatomic, copy) NSString *loadingType;
    
+ (void)show;
+ (void)hide;
    
+ (void)showFromView:(UIView *)superView;
+ (void)hideFromView:(UIView *)superView;
    
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message view:(UIView *)superView;
    
+ (void)showAnimation;
+ (void)showAnimationFromView:(UIView *)superView;
+ (void)hideAnimation;
+ (void)hideAnimationFromView:(UIView *)superView;

+ (id)shareInstance;
    
- (void)showLoadingForView:(UIView *)view;
    
- (void)hideLoading;
    
@end

NS_ASSUME_NONNULL_END
