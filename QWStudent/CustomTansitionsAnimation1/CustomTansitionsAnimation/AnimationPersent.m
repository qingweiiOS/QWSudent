//
//  AnimationPersent.m
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "AnimationPersent.h"

//动画时间
static NSTimeInterval tTimeInterva = 0.7;
@implementation AnimationPersent

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
    //创建副本
    UIView *animationView = [fromVC.view  snapshotViewAfterScreenUpdates:NO];
    animationView.tag = 100;
    fromVC.view.hidden = YES;
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, 400);
    [containerView addSubview:animationView];
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:tTimeInterva animations:^{
        animationView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        //目标 向上移动
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        //截图视图 缩放
        animationView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        //转场过渡完成
           [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            //失败后 源视图显示
//            fromVC.view.hidden = NO;
            //移除截图视图，因为下次触发present会重新截图
//           [animationView removeFromSuperview];
    }];

}
@end
