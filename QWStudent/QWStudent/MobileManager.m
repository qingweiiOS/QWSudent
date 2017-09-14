//
//  MobileManager.m
//  QWStudent
//
//  Created by jonh on 2017/8/15.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "MobileManager.h"
#import "TransitionViewController.h"
#import "MobileViewController.h"
#define TIMEINTERVAL 1.0
@implementation MobileManager
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return TIMEINTERVAL;
}
/// pop 动画类似 相反而已
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //de到源视图控制器
    TransitionViewController *formVC = (TransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //de到目标视图控制器
    MobileViewController *toVC = (MobileViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //得到动画内容展示 视图 容器 （系统提供） 我们将要在这个视图上进行动画操作
    UIView *animationView = [transitionContext containerView];
    /*
     * 得到源视图 要处理的视图 并且创建副本 [截图 懂不]
     * snapshotViewAfterScreenUpdates YES 白板。NO 有内容
     */
    UIView *formView = [formVC.yidongView snapshotViewAfterScreenUpdates:NO];
    
    /*
     * 转化坐标
     *
     *
     */
    formView.frame = [formVC.yidongView convertRect:formVC.yidongView.bounds toView:animationView];
    
    /*
     * 先看动画效果
     * 原理 将要移动的视图 和 移动的目标视图 添加到动画容器中animationView 进行动画处理
     *
     */
    //注意顺序
    
    // 1、目标视图
    [animationView addSubview:toVC.view];
    //2、源视图
     [animationView addSubview:formVC.view];
    //3、将要操作的视图
    [animationView addSubview:formView];
  
    
    //隐藏 目标 动画完成后 再显示  formVC.yidongView移动到 toVC.imgView
    formVC.yidongView.hidden = YES;
    toVC.imgView.hidden = YES;
    //将要推出的界面 透明度逐渐降低 （效果好点）
    formVC.view.alpha = 1.0;
    [UIView animateWithDuration:TIMEINTERVAL animations:^{
        //移动位置
        formView.frame = [toVC.imgView convertRect:toVC.imgView.bounds toView:animationView];
        //push控制器由透明为1变为0 最后动画完成后要修改为1
        formVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        //动画完成后
        //告诉系统动画完成。必须
        [transitionContext completeTransition:YES];
        formView.hidden = YES;
        toVC.imgView.hidden = NO;
        formVC.view.alpha = 1.0;
        formVC.yidongView.hidden = NO;
        [formView removeFromSuperview];
    }];
    
    
 
    

}

@end
