//
//  AnimationPersent.m
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "AnimationDismis.h"

//动画时间
static NSTimeInterval tTimeInterva = 0.7;
@implementation AnimationDismis

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return tTimeInterva;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //得到 源视图控制器 UITransitionContextFromViewControllerKey
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //得到 目标视图控制器 UITransitionContextToViewControllerKey
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /**
     * 得到动画内容展示视图 容器 ［动画将要在 containerView 上展示］
     */
    UIView *containerView = [transitionContext containerView];
    //得到副本
    UIView *views = [containerView viewWithTag:100];
    
    NSLog(@"%@",views);
    
    
     [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
        views.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        //动画过度 是否 完成
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        if(![transitionContext transitionWasCancelled])
        {
            toVC.view.hidden = NO;
            [views removeFromSuperview];
        }
        
        

        
    }];
    
    
  
}
@end
