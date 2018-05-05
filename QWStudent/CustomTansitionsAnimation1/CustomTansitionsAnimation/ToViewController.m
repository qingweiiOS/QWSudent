//
//  ToViewController.m
//  自定义专场动画
//
//  Created by qingweiqw on 16/12/12.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "ToViewController.h"
#import "AnimationPop.h"
@interface ToViewController ()
//百分比推动 动画 ［通过设置该参数（0-1） UIKit自动执行Pop动画］
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation ToViewController
- (UIImageView *)imgView
{
    if(!_imgView)
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-100,self.view.frame.size.width-100 )];
        _imgView.backgroundColor = [UIColor redColor];
    }
    return _imgView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imgView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate=self;
}
- (void)setImgName:(NSString *)imgName
{
    if(!self.isViewLoaded)
    {
        [self viewDidLoad];
    }
    _imgName = imgName;
    self.imgView.image = [UIImage imageNamed:_imgName];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pops:)];
    [self.view addGestureRecognizer:pan];
}
//手势
- (void)pops:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    CGFloat scale = 2*(point.x/self.view.frame.size.width);
        NSLog(@"%.2f",scale);
    
        if(scale < 0)
        {
           if(pan.state == UIGestureRecognizerStateCancelled||pan.state == UIGestureRecognizerStateEnded)
           {
                [self.interactiveTransition cancelInteractiveTransition];
               
           }
        }
        else if(pan.state == UIGestureRecognizerStateBegan)
        {
            
            
            self.interactiveTransition = [UIPercentDrivenInteractiveTransition new];
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        else if(pan.state == UIGestureRecognizerStateChanged)
        {
           
            [self.interactiveTransition updateInteractiveTransition:scale];
            
            
        }
        else  // 手势取消或者完成
        {
            //判定 pop完成
            if (scale >=0.5) {
                [ self.interactiveTransition finishInteractiveTransition];
            }else{
                
                //取消
                [self.interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
        }
    
}
//为动画 添加用户交互
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactiveTransition;
}
//自定义动画哟
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPop)
    {
        AnimationPop *pop = [AnimationPop new];
        return pop;
    }
    else
    {
        return nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
