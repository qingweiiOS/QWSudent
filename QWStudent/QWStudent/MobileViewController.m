//
//  MobileViewController.m
//  QWStudent
//
//  Created by jonh on 2017/8/15.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "MobileViewController.h"
#import "PopMobileManager.h"
@interface MobileViewController ()<UINavigationControllerDelegate>

@end

@implementation MobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 400, self.view.frame.size.width-20,180)];
    self.imgView.center = self.view.center;
    self.imgView.image = self.img;
    [self.view addSubview:self.imgView];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.delegate = self;
}
//自定义动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPush)
    {
      
       
        return nil;
    }
    else
    {
          // 使用 自定义的pop动画
        PopMobileManager *pop = [PopMobileManager new];
        return pop;
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
