//
//  YAYViewController.m
//  QWStudent
//
//  Created by jonh on 2017/9/14.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "YAYViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface YAYViewController ()
@property (strong, nonatomic) CMMotionManager *motionManager;
@end

@implementation YAYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建CMMotionManager对象
    self.motionManager= [[CMMotionManager alloc] init];
    //设置加速仪更新频率，以秒为单位
    self.motionManager.accelerometerUpdateInterval =0.1;
    // Do any additional setup after loading the view.
}
- (void)viewDidDisappear:(BOOL)animated{
        [self.motionManager stopAccelerometerUpdates];
        //取消监听
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}
- (void)receiveNotification:(NSNotification*)notification {
    
    if([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        
        [self.motionManager stopAccelerometerUpdates];
        
    }else {
        
        [self startAccelerometer];
        
    }
}
- (void)viewWillAppear:(BOOL)animated{
   
    //添加进入前台或进入后台的监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self startAccelerometer];
}
-(void)startAccelerometer {
    
    //以push的方式更新并在block中接收加速度
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData*accelerometerData,NSError*error) {
        
        [self outputAccelertionData:accelerometerData.acceleration];
        
        if(error) {
            
            NSLog(@"motion error:%@",error);
            
        }
        
    }];
    
}

- (void)outputAccelertionData:(CMAcceleration)acceleration {
    
    //综合3个方向的加速度
    
    double accelerameter =sqrt( pow( acceleration.x,2) + pow( acceleration.y,2) + pow( acceleration.z,2) );
    
    //当综合加速度大于3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    
    if(accelerameter>3.0f) {
        
        //立即停止更新加速仪 （很重要！） 我这里就不停止了、因为我要一直 摇摇摇
        //[self.motionManager stopAccelerometerUpdates];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
            NSLog(@"123");
            self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
//            [self.motionManager stopAccelerometerUpdates];
            
        });
        
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
