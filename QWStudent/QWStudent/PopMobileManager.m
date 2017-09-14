//
//  MobileManager.m
//  QWStudent
//
//  Created by jonh on 2017/8/15.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "PopMobileManager.h"
#import "TransitionViewController.h"
#import "MobileViewController.h"
#define TIMEINTERVAL 1.0
@implementation PopMobileManager
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return TIMEINTERVAL;
}
/// pop 动画类似 相反而已 这里就不做了 原理就是这样
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //de到源视图控制器
     MobileViewController *formVC = (MobileViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //de到目标视图控制器
     TransitionViewController *toVC = (TransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //得到动画内容展示 视图 容器 （系统提供） 我们将要在这个视图上进行动画操作
    UIView *animationView = [transitionContext containerView];
    /*
     * 得到源视图 要处理的视图 并且创建副本 [截图 懂不]
     * snapshotViewAfterScreenUpdates YES 白板。NO 有内容
     */
    
    UIView *formView = [formVC.imgView snapshotViewAfterScreenUpdates:NO];
    
    /*
     * 转化 formView 在 animationView 中的相对坐标
     */
    formView.frame = [formVC.imgView convertRect:formVC.imgView.bounds toView:animationView];
    
    /*
     * 先看动画效果
     * 原理 将要移动的视图 和 移动的目标视图 添加到动画容器中animationView 进行动画处理
     *
     */
    // 注意视图的添加顺序
    //1、添加目标视图
    [animationView addSubview:toVC.view];
    //2、添加源视图
    [animationView addSubview:formVC.view];
    //3.将要操作的视图
    [animationView addSubview:formView];
    //隐藏 目标 动画完成后 再显示  formVC.yidongView移动到 toVC.imgView
    formVC.imgView.hidden = YES;
    toVC.yidongView.hidden = YES;
    //将要推出的界面 透明度逐渐降低 （效果好点）
    formVC.view.alpha = 1.0;
    [UIView animateWithDuration:TIMEINTERVAL animations:^{
        //移动位置
        formView.frame = [toVC.yidongView convertRect:toVC.yidongView.bounds toView:animationView];
        //控制器由透明为0变为1
        formVC.view.alpha = 0.0;

    } completion:^(BOOL finished) {
        //动画完成后
        //告诉系统动画完成 （必须）
        [transitionContext completeTransition:YES]; //这句代码必须执行 必须执行 必须执行0
        formView.hidden = NO;
        toVC.yidongView.hidden = NO;
        formVC.imgView.hidden = NO;
        formVC.view.alpha = 1.0;
        [formView removeFromSuperview];
    }];
    
    
    
    
    
}

@end
