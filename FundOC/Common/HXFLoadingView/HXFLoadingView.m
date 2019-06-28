//
//  HXFLoadingView.m
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFLoadingView.h"

#define HXF_MESSAGE_DEFAULT_HEIGHT 40
#define HXF_MESSAGE_FONT [UIFont systemFontOfSize:14]
#define HXF_MESSAGE_TOP_MARGIN 10
#define HXF_MESSAGE_LEFT_MARGIN 12
#define HXF_MESSAGE_CORNER_RADIUS 7

#define HXF_ANIMATE_DURATION 0.2
#define HXF_LOADING_SIDE_WIDTH 70
#define HXF_LOADING_CORNER_RADIUS 10

#define HXF_TOAST_TYPE_LOADING @"hxf_type_loading"
#define HXF_TOAST_TYPE_MESSAGE @"hxf_type_message"
#define HXF_TOAST_TYPE_ANIMATION @"hxf_type_animation"

@interface HXFLoadingView ()
    
@property (nonatomic, copy) NSArray *imageArray;
    
//@property (nonatomic, strong) LOTAnimationView *animationImageV;

@end

@implementation HXFLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
 
+ (void)show {
    [self showFromView:[UIApplication sharedApplication].keyWindow];
}
+ (void)hide {
    [self hideFromView:[UIApplication sharedApplication].keyWindow];
}
    
+ (void)showFromView:(UIView *)superView {
    
    // 如果已经存在则不再添加
    for (UIView *itemView in superView.subviews) {
        if ([itemView isKindOfClass:[HXFLoadingView class]] &&
            [((HXFLoadingView *)itemView).loadingType isEqualToString:HXF_TOAST_TYPE_LOADING]) {
            return ;
        }
    }
    HXFLoadingView *view = [HXFLoadingView new];
    view.loadingType = HXF_TOAST_TYPE_LOADING;
    view.frame = CGRectMake(0, 0, HXF_LOADING_SIDE_WIDTH, HXF_LOADING_SIDE_WIDTH);
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:HXF_LOADING_CORNER_RADIUS];
    view.center = CGPointMake(superView.bounds.size.width / 2.f, superView.bounds.size.height / 2.f);
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
    UIActivityIndicatorView *activityView = [UIActivityIndicatorView new];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityView.center = CGPointMake(HXF_LOADING_SIDE_WIDTH / 2.f, HXF_LOADING_SIDE_WIDTH / 2.f);
    
    [view addSubview:activityView];
    [activityView startAnimating];
    view.alpha = 0;
    [superView addSubview:view];
    [UIView animateWithDuration:HXF_ANIMATE_DURATION animations:^{
        view.alpha = 1;
    }];
}
+ (void)hideFromView:(UIView *)superView {
    
    for (UIView *itemView in superView.subviews) {
        
        if ([itemView isKindOfClass:[HXFLoadingView class]] && [((HXFLoadingView *)itemView).loadingType isEqualToString:HXF_TOAST_TYPE_LOADING]) {
            
            [UIView animateWithDuration:HXF_ANIMATE_DURATION animations:^{
                itemView.alpha = 0;
            } completion:^(BOOL finished) {
                [itemView removeFromSuperview];
                
                return ;
            }];
        }
    }
}
    
+ (void)showMessage:(NSString *)message {
    
    [self showMessage:message view:[UIApplication sharedApplication].keyWindow];
}
+ (void)showMessage:(NSString *)message view:(UIView *)superView {
    
    HXFLoadingView *messageView = [HXFLoadingView new];
    messageView.loadingType = HXF_TOAST_TYPE_MESSAGE;
    messageView.clipsToBounds = YES;
    [messageView.layer setMasksToBounds:YES];
    [messageView.layer setCornerRadius:HXF_MESSAGE_CORNER_RADIUS];
    messageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
    CGFloat testWidth = [self autoWidthWithString:message font:HXF_MESSAGE_FONT];
    CGFloat messageViewMaxWidth = superView.bounds.size.width - HXF_MESSAGE_LEFT_MARGIN * 2;
    CGFloat labelMaxWidth = messageViewMaxWidth - HXF_MESSAGE_LEFT_MARGIN * 2;
    
    UILabel *label = [UILabel new];
    label.font = HXF_MESSAGE_FONT;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.text = message;
    
    if (testWidth <= messageViewMaxWidth - HXF_MESSAGE_LEFT_MARGIN * 2) {
        messageView.frame = CGRectMake(0, 0, testWidth + HXF_MESSAGE_LEFT_MARGIN * 2, HXF_MESSAGE_DEFAULT_HEIGHT);
        label.frame = CGRectMake(0, 0, testWidth, HXF_MESSAGE_DEFAULT_HEIGHT);
    }else {
        CGFloat testHeight = [self autoHeightWithString:message width:labelMaxWidth Font:HXF_MESSAGE_FONT];
        messageView.frame = CGRectMake(0, 0, messageViewMaxWidth, testHeight + HXF_MESSAGE_TOP_MARGIN * 2);
        label.frame = CGRectMake(0, 0, labelMaxWidth, testHeight);
    }
    messageView.center = CGPointMake(superView.bounds.size.width / 2.f, superView.bounds.size.height / 2.f);
    label.center = CGPointMake(messageView.bounds.size.width / 2.f, messageView.bounds.size.height / 2.f);
    
    [messageView addSubview:label];
    messageView.alpha = 0;
    [superView addSubview:messageView];
    [UIView animateWithDuration:HXF_ANIMATE_DURATION animations:^{
        messageView.alpha = 1;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:HXF_ANIMATE_DURATION animations:^{
            messageView.alpha = 0;
        } completion:^(BOOL finished) {
            [messageView removeFromSuperview];
        }];
    });
}
    
+ (void)showAnimation {
    
    [self showAnimationFromView:[UIApplication sharedApplication].keyWindow];
    // 延时3秒隐藏加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hideAnimation];
    });
}
    
+ (void)showAnimationFromView:(UIView *)superView {
    
    // 如果已经存在则不再添加
    for (UIView *itemView in superView.subviews) {
        if ([itemView isKindOfClass:[HXFLoadingView class]] &&
            [((HXFLoadingView *)itemView).loadingType isEqualToString:HXF_TOAST_TYPE_ANIMATION]) {
            return ;
        }
    }
    HXFLoadingView *animationView = [HXFLoadingView new];
    //    animationView.backgroundColor = [UIColor blackColor];
    
    
    animationView.loadingType = HXF_TOAST_TYPE_ANIMATION;
    CGFloat imageWidth = 50.0f;
    CGFloat imageHeight = 50.0f;
    //    animationView.frame = CGRectMake(0, 0, imageWidth, imageHeight);
    animationView.frame = superView.bounds;
    //    animationView.center = CGPointMake(superView.bounds.size.width / 2.f, superView.bounds.size.height / 2.f);
    //    [animationView.layer setMasksToBounds:YES];
    //    [animationView.layer setCornerRadius:DVV_LOADING_CORNER_RADIUS];
    animationView.contentMode = UIViewContentModeScaleAspectFit;
    //        animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(0, 0, imageWidth, imageHeight);
    imageView.center = CGPointMake(animationView.bounds.size.width/2.f, animationView.bounds.size.height / 2.f);
    
    [animationView addSubview:imageView];
    imageView.animationImages = [self refreshIamgesArray];
    imageView.animationDuration = 3;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
    //    animationView.alpha = 0;
    [superView addSubview:animationView];
    [UIView animateWithDuration:HXF_ANIMATE_DURATION animations:^{
        //        animationView.alpha = 0.5;
        
    }];
}
    
+ (void)hideAnimation {
    
    [self hideAnimationFromView:[UIApplication sharedApplication].keyWindow];
}
    
+ (void)hideAnimationFromView:(UIView *)superView {
    
    for (UIView *itemView in superView.subviews) {
        
        if ([itemView isKindOfClass:[HXFLoadingView class]] && [((HXFLoadingView *)itemView).loadingType isEqualToString:HXF_TOAST_TYPE_ANIMATION]) {
            
            [UIView animateWithDuration:HXF_ANIMATE_DURATION animations:^{
                itemView.alpha = 0;
            } completion:^(BOOL finished) {
                [itemView removeFromSuperview];
                
                return ;
            }];
        }
    }
}
    
#pragma mark - public
    
+ (NSArray *)refreshIamgesArray {
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 2; i <= 11; i++) {
        
        NSString *name = [NSString stringWithFormat:@"gb_loading-%i",i];
        [array addObject:name];
    }
    NSMutableArray *imagesArray = [NSMutableArray array];
    for (NSString *string in array) {
        
        CGSize size = CGSizeMake(100, 100);
        UIImage *image = [self resizeImage:[UIImage imageNamed:string] newSize:size];
        [imagesArray addObject:image];
    }
    return imagesArray;
}
    
+ (UIImage *)resizeImage:(UIImage *)image newSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect;
    rect.origin = CGPointMake(0, 0);
    rect.size = newSize;
    [image drawInRect:rect];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizeImage;
}
    
+ (CGFloat)autoHeightWithString:(NSString *)string width:(CGFloat)width Font:(UIFont *)font {
    
    CGSize boundRectSize = CGSizeMake(width, MAXFLOAT);
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.height;
    return newFloat;
}
    
+ (CGFloat)autoWidthWithString:(NSString *)string font:(UIFont *)font {
    
    CGSize boundRectSize = CGSizeMake(MAXFLOAT, font.lineHeight);
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.width;
    return newFloat;
}

    
    
+ (id)shareInstance
{
    static HXFLoadingView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HXFLoadingView alloc]init];
        [instance createPage];
    });
    return instance;
}
    
- (void)createPage
{
    self.frame = CGRectMake(0, 0, hxf_ScreenWidth, hxf_ScreenHeight);
        
    //
    UIView *clearView = [[UIView alloc]init];
    [clearView setBackgroundColor:[[UIColor whiteColor]colorWithAlphaComponent:0]];
    [clearView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
    [self addSubview:clearView];
        
//    self.animationImageV.centerX = self.centerX;
//    self.animationImageV.centerY = self.centerY+40;
//    //    self.animationImageV = imageV;
//    [self addSubview:self.animationImageV];
}
    
//- (LOTAnimationView*)animationImageV
//{
//    if (_animationImageV == nil) {
//        _animationImageV = [LOTAnimationView animationNamed:@"netFlower"];
//        _animationImageV.frame = CGRectMake(0, 0, 75, 75);
//        _animationImageV.loopAnimation = YES;
//        _animationImageV.userInteractionEnabled = NO;
//    }
//    return _animationImageV;
//}
    
- (void)showLoadingForView:(UIView *)view
{
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//
//    [self.animationImageV stop];
//    [self.animationImageV play];
    
}
    
- (void)hideLoading
{
    [self removeFromSuperview];
}

@end
