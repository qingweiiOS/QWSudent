//
//  ToPopOneViewController.m
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "ToPopOneViewController.h"
#import "AnimationDismis.h"
#import "AnimationPersent.h"

@interface ToPopOneViewController (){
    UIButton *btn;
}
@property (strong,nonatomic) UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation ToPopOneViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100,self.view.frame.size.width-200, self.view.frame.size.width-200)];
    imageView.image = [UIImage imageNamed:@"girs2"];
    [self.view addSubview:imageView];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 40)];
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [self.view addGestureRecognizer:pan];
}

- (void)dismiss:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    CGFloat scale = point.y/100;
    if(scale < 0)
    {
        if(pan.state == UIGestureRecognizerStateCancelled||pan.state == UIGestureRecognizerStateEnded)
        {
            [self.interactiveTransition cancelInteractiveTransition];
            
        }
    }
    else if(pan.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"start");
        self.interactiveTransition = [UIPercentDrivenInteractiveTransition new];
        [self dismis];
        [self.interactiveTransition updateInteractiveTransition:0.01];
    }
    else if(pan.state == UIGestureRecognizerStateChanged)
    {
        if(scale>=1.0)
        {
            scale = 1.0;
        }
        [self.interactiveTransition updateInteractiveTransition:scale];
        NSLog(@"move");
        
    }
    else  // 手势取消或者完成
    {
        NSLog(@"end");
        
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
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [AnimationDismis new];
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [AnimationPersent new];
    
}
- (void)dismis
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return  self.interactiveTransition;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
