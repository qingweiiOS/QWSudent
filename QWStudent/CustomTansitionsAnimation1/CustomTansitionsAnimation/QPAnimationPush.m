//
//  QPAnimationPush.m
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.

#import "QPAnimationPush.h"

static NSTimeInterval timeInterval = 1.0;

@interface QPAnimationPush () {
   
    NSMutableArray *viewArrays;
}
@end
@implementation QPAnimationPush
- (instancetype)initWithTransType:(transType)transType {
    self = [super init];
    if (self) {
        self.transTypes = transType;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return timeInterval;
}
// This method can only  be a nop if the transition is interactive and not a 、percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.transTypes) {
        case PUSH:
            [self push:transitionContext];
            break;
        case POP:
            [self pop:transitionContext];
            break;
        default:
            
            NSLog(@"设置跳转类型没有a?骚年！");
            break;
    }
}
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //得到 源视图控制器 UITransitionContextFromViewControllerKey
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //得到 目标视图控制器 UITransitionContextToViewControllerKey
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /**
     * 得到动画内容展示视图 容器 ［动画将要在 containerView 上展示］
     */
    UIView *containerView = [transitionContext containerView];
    //创建副本
    UIView *fromView = [fromVC.view  snapshotViewAfterScreenUpdates:NO];
    
    toVC.view.alpha = 0.5;
    fromView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    
  
    [containerView addSubview:toVC.view];
    NSArray *farray = [self qietu:fromView];
    
//    NSArray *tarray = [self qietu:[toVC view]];
    for(int i=0;i<farray.count;i++)
    {
        UIView *fview = farray[i];
        
//        UIView *tview = tarray[i];
//        CGRect rect = CGRectMake(-CGRectGetWidth(tview.frame), i, CGRectGetWidth(tview.frame), CGRectGetMinY(tview.frame));
//        tview.frame = rect;
        [containerView addSubview:fview];
//        3/2  --  3   1.5+ (0-1.5)
        CGFloat animationTime =1.5+ (arc4random_uniform(100)/100.0)*(timeInterval/2);
        
        int index = i%2?1:(-1);
        [UIView animateKeyframesWithDuration:animationTime delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            fview.frame = CGRectMake( index*containerView.frame.size.width, CGRectGetMinY(fview.frame), containerView.frame.size.width,CGRectGetHeight(fview.frame));
//            tview.frame = CGRectMake(0, i, CGRectGetWidth(tview.frame), CGRectGetMinY(tview.frame));
            toVC.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            
            [fview removeFromSuperview];
            //            [tview removeFromSuperview];
            
        }];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        fromView.hidden = NO;

         [transitionContext completeTransition:YES];
    });
    
}
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    //得到 源视图控制器 UITransitionContextFromViewControllerKey
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //得到 目标视图控制器 UITransitionContextToViewControllerKey
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /**
     * 得到动画内容展示视图 容器 ［动画将要在 containerView 上展示］
     */
    UIView *containerView = [transitionContext containerView];
    //创建副本
    UIView *fromView = [fromVC.view  snapshotViewAfterScreenUpdates:NO];
    toVC.view.alpha = 0.5;
    fromView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    

    [containerView addSubview:toVC.view];
    NSArray *farray = [self qietu:fromView];
    
    //    NSArray *tarray = [self qietu:[toVC view]];
    for(int i=0;i<farray.count;i++)
    {
        UIView *fview = farray[i];
        
          [containerView addSubview:fview];
         CGFloat animationTime =1.5+ (arc4random_uniform(100)/100.0)*(timeInterval/2);
        int index = i%2?1:(-1);
        
        [UIView animateKeyframesWithDuration:animationTime delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            fview.frame = CGRectMake( index*containerView.frame.size.width, CGRectGetMinY(fview.frame), containerView.frame.size.width,CGRectGetHeight(fview.frame));
//(tview.frame), CGRectGetMinY(tview.frame));
            toVC.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            
            [fview removeFromSuperview];
            //            [tview removeFromSuperview];
                   }];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        fromView.hidden = NO;
        [transitionContext completeTransition:YES];
       
    });
  
}
- (NSArray *)qietu:(UIView *)views
{
    CGFloat height = views.frame.size.height/100;
    NSMutableArray *tempArray = [NSMutableArray array];
    for(int i=0;i<=CGRectGetHeight(views.frame);i+=height)
    {
        CGRect rect = CGRectMake(0, i, CGRectGetWidth(views.frame), height);
        UIView *tempView = [views resizableSnapshotViewFromRect:rect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        tempView.frame = rect;
        [tempArray addObject:tempView];
       
    }
    return tempArray;
}
@end
