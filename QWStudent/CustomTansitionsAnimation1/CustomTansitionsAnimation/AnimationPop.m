//
//  animationPush.m
//  自定义专场动画
//
//  Created by qingweiqw on 16/12/12.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "AnimationPop.h"
#import "OneViewController.h"
#import "ToViewController.h"
#import "OneCollectionViewCell.h"
@implementation AnimationPop
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //神奇移动呼呼
    //得到 源视图控制器 UITransitionContextFromViewControllerKey
    ToViewController *fromVC =(ToViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //得到 目标视图控制器 UITransitionContextToViewControllerKey
    OneViewController *toVC = (OneViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //得到动画  内容 展示视图 ［动画将要在 containerView 上展示］
    UIView *containerView = [transitionContext containerView];
    NSLog(@"%lu",(unsigned long)containerView.subviews.count);
    //创建副本
    UIView *animationView = [fromVC.imgView snapshotViewAfterScreenUpdates:NO];
    //拿到当前点击的cell的imageView
    OneCollectionViewCell *cell = toVC.oneCell;
    
    //转化坐标
    animationView.frame = [fromVC.imgView convertRect:fromVC.imgView.bounds toView:containerView];
    
    //    containerView.backgroundColor = [UIColor redColor];
//    NSLog(@"%@",[NSValue valueWithCGRect: animationView.frame ]);
    [containerView addSubview:toVC.view];
    [containerView addSubview:animationView];
    
    //动画内容
    //设置相关初始值
    cell.headImage.hidden = YES;
    toVC.view.alpha = 0.0;
    fromVC.imgView.hidden = YES;
    
    [UIView animateWithDuration:0.7 animations:^{
        
        animationView.frame = [toVC.oneCell.headImage convertRect:toVC.oneCell.headImage.bounds toView:containerView];
        //push控制器由透明为0变为1
        toVC.view.alpha = 1.0;
        fromVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        //动画过度 是否 完成
          [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        fromVC.imgView.hidden = NO;
        cell.headImage.hidden = NO;
        [animationView removeFromSuperview];

}];
    
}
@end
