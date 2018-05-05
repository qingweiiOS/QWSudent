//
//  OneViewController.m
//  自定义专场动画
//
//  Created by qingweiqw on 16/12/12.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "OneViewController.h"
#import "OneCollectionViewCell.h"
#import "ToViewController.h"
#import "animationPush.h"

@interface OneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>
@property (strong,nonatomic) UICollectionView *collectionView;

@end

@implementation OneViewController
- (UICollectionView *)collectionView
{
    if(!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(150, 150);
        _collectionView =  [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"OneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OneCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OneCollectionViewCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ToViewController *toVC = [[ToViewController alloc] init];
    _oneCell = (OneCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    toVC.imgName = @"girs";
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:toVC animated:YES];
}
//自定义动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPush)
    {
        animationPush *push = [animationPush new];
        return push;
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
