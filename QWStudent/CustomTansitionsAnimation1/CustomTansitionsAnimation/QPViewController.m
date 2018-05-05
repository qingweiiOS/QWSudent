//
//  QPViewController.m
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QPViewController.h"
#import "ToQPViewController.h"
#import "QPAnimationPush.h"
@interface QPViewController ()<UINavigationControllerDelegate>

@end

@implementation QPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"girs2"];
    [self.view addSubview:imageView];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 40)];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(prestn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.view.backgroundColor = [UIColor cyanColor];
}
- (void)prestn
{
    ToQPViewController *qp = [[ToQPViewController alloc] init];
    qp.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:qp animated:YES];
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPush)
    {
        return [[QPAnimationPush alloc] initWithTransType:PUSH];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
