//
//  ToQPViewController.m
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "ToQPViewController.h"
#import "QPAnimationPush.h"

@interface ToQPViewController ()<UINavigationControllerDelegate>

@end

@implementation ToQPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"girs"];
    [self.view addSubview:imageView];
   }
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPop)
    {
        QPAnimationPush *qp = [[QPAnimationPush alloc] initWithTransType:POP];
        return qp;
    }
    else
    {
      return nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.delegate = self;

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
