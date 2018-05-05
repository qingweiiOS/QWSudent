//
//  PopOneViewController.m
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "PopOneViewController.h"
#import "ToPopOneViewController.h"
#import "AnimationPersent.h"

@interface PopOneViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation PopOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100,self.view.frame.size.width-200, self.view.frame.size.width-200)];
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
    ToPopOneViewController *toVC = [[ToPopOneViewController alloc] init];
    toVC.view.backgroundColor = [UIColor whiteColor];
    
    [self presentViewController:toVC animated:YES completion:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
