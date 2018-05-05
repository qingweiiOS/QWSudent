//
//  MainTableViewController.m
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "MainTableViewController.h"
#import <Foundation/Foundation.h>

@interface MainTableViewController ()
{
    
    NSArray *titleArrray;
    NSArray *vcArray;
}

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)];
    //CGFloat x = 100;
    //CGFloat y =100;
    //UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:self.tableView.center radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    //CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
   // self.tableView.layer.mask = maskLayer;

    [self initData];
}
- (void)initData
{
    titleArrray = @[@"神奇移动",@"弹性PerSent",@"Animation1"];
    vcArray  = @[@"OneViewController",@"PopOneViewController",@"QPViewController"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return titleArrray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
     if(!cell)
     {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"acell"];
     }
    cell.textLabel.text = titleArrray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[NSClassFromString(vcArray[indexPath.row]) alloc] init];
    
    vc.title = titleArrray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
