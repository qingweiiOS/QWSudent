//
//  TransitionViewController.m
//  QWStudent
//
//  Created by jonh on 2017/8/15.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "TransitionViewController.h"
#import "MobileViewController.h"
#import "MobileManager.h"
#import "PopMobileManager.h"
@interface TransitionViewController ()<UINavigationControllerDelegate>
{

    
}

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}
- (void)initUI {
    self.yidongView = [[UIImageView alloc] initWithFrame:CGRectMake(100,100, 100, 50)];
    [self.view addSubview:self.yidongView ];
    self.yidongView .userInteractionEnabled = YES;
    self.yidongView .image = [UIImage imageNamed:@"4.jpg"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yidong)];
    [self.yidongView  addGestureRecognizer:tap];
    
}

- (void)yidong{
    MobileViewController *mobileVC = [[MobileViewController alloc] init];
    mobileVC.img = self.yidongView .image;
      self.navigationController.delegate = self;
    [self.navigationController pushViewController:mobileVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//自定义动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPush)
    {
        // 使用 自定义的push动画
        MobileManager *push = [MobileManager new];
        return push;
    }
    else
    {
//        PopMobileManager *pop = [PopMobileManager new];
        return nil;
    }
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
