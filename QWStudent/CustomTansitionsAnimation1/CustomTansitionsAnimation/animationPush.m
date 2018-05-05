//
//  animationPush.m
//  自定义专场动画
//
//  Created by qingweiqw on 16/12/12.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "animationPush.h"
#import "OneViewController.h"
#import "ToViewController.h"
#import "OneCollectionViewCell.h"
//动画时间
static NSTimeInterval tTimeInterva = 0.7;
@implementation animationPush

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return tTimeInterva;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //神奇移动呼呼
    //得到 源视图控制器 UITransitionContextFromViewControllerKey
    OneViewController *fromVC =(OneViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //得到 目标视图控制器 UITransitionContextToViewControllerKey
    ToViewController *toVC = (ToViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /**
     * 得到动画内容展示视图 容器 ［动画将要在 containerView 上展示］
     */
    UIView *containerView = [transitionContext containerView];
   
    //创建副本
    UIView *animationView = [fromVC.oneCell.headImage snapshotViewAfterScreenUpdates:NO];
    //拿到当前点击的cell的imageView
    OneCollectionViewCell *cell = fromVC.oneCell;
     //转化坐标
    animationView.frame = [cell.headImage convertRect:cell.headImage.bounds toView:containerView];
    //当动画过渡完成后
    [containerView addSubview:toVC.view];
    //
    [containerView addSubview:animationView];
    //动画内容
    //设置相关初始值
    cell.headImage.hidden = YES;
    animationView.alpha = 1.0;
    toVC.view.alpha = 0.0;
    toVC.imgView.hidden = YES;
    //动画效果
    [UIView animateWithDuration:0.7 animations:^{
        animationView.frame = [toVC.imgView convertRect:toVC.imgView.bounds toView:containerView];
            //push控制器由透明为0变为1
        toVC.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        //动画过度完成 ［必须］
        [transitionContext completeTransition:YES];
        animationView.hidden = YES;
        toVC.imgView.hidden = NO;
        fromVC.oneCell.headImage.hidden = NO;
        [animationView removeFromSuperview];
    }];
    
}
@end
