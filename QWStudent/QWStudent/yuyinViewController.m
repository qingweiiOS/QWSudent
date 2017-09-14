//
//  yuyinViewController.m
//  QWStudent
//
//  Created by jonh on 2017/9/12.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "yuyinViewController.h"
#import "UIView+Extension.h"
#import <Speech/Speech.h>
//info.plist添加如下两个key
//Privacy - Speech Recognition Usage Description
//Privacy - Microphone Usage Description

@interface yuyinViewController (){
    NSString *content;//保存语音输入前的 内容
}
@property (nonatomic, strong) UITextView *tempView;
@property (nonatomic, strong) UIButton *toolBar;
@property (nonatomic, strong) AVAudioEngine *audioEngine;                           // 声音处理器
@property (nonatomic, strong) SFSpeechRecognizer *speechRecognizer;                 // 语音识别器
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *speechRequest; // 语音请求对象
@property (nonatomic, strong) SFSpeechRecognitionTask *currentSpeechTask;           // 当前语音识别进程
@end

@implementation yuyinViewController
- (UITextView *)tempView{

    if(!_tempView){
    
        _tempView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, 200, 100)];
        _tempView.layer.borderColor = [UIColor grayColor].CGColor;
        _tempView.layer.borderWidth = 0.5;
//        _tempView.center = self.view.center;
    }
    return _tempView;
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    [self initUI];
    [self configureVoiceInput];
}
- (void)configureVoiceInput{

    // 初始化语音处理器
    self.audioEngine = [[AVAudioEngine alloc] init];
    // 初始化语音识别器
    self.speechRecognizer = [[SFSpeechRecognizer alloc] init];
    
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status)
     {
         if (status != SFSpeechRecognizerAuthorizationStatusAuthorized)
         {
             // 如果状态不是已授权则return 可以提示用户授权 设置 - 隐私 - 麦克风／语音识别
             NSLog(@"没有授权");
             return;
         }
         
         // 初始化语音处理器的输入模式
         [self.audioEngine.inputNode installTapOnBus:0 bufferSize:1024 format:[self.audioEngine.inputNode outputFormatForBus:0] block:^(AVAudioPCMBuffer * _Nonnull buffer,AVAudioTime * _Nonnull when)
          {
              //为语音识别请求对象添加一个AudioPCMBuffer，来获取声音数据
              [self.speechRequest appendAudioPCMBuffer:buffer];
          }];
         // 语音处理器准备就绪（会为一些audioEngine启动时所必须的资源开辟内存）
         [self.audioEngine prepare];
     }];

}
//结束语音录入
- (void)stopDictating
{
    //停止声音处理器
    [self.audioEngine stop];
    //停止 语音识别请求的进程
    [self.speechRequest endAudio];
}
//开始语音录入
- (void)startDictating
{
    NSError *error;
    // 开启声音处理器
    [self.audioEngine startAndReturnError: &error];
    // 初始化语音识别请求
    self.speechRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    // 使用speechRequest请求进行语音识别
    self.currentSpeechTask =
    [self.speechRecognizer recognitionTaskWithRequest:self.speechRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result,NSError * _Nullable error)
     {
         // 识别结果，识别后的操作
         if (result == NULL) return;//未识别
         NSLog(@"%@",result.bestTranscription.formattedString);//识别成功
         // 识别结果会自动进行纠正
         self.tempView.text = [NSString stringWithFormat:@"%@%@",content,result.bestTranscription.formattedString];
     }];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tempView];
    self.toolBar = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, 50)];
    [self.toolBar setImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateNormal];
    [self.toolBar setTitle:@"长按可语音录入" forState:UIControlStateNormal];
    [self.toolBar setTitle:@"录入中" forState:UIControlStateSelected];
    [self.toolBar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(voiceInput:)];
    [self.toolBar addGestureRecognizer:tap];
    self.toolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.toolBar];
    //j
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];//
    
}
- (void)voiceInput:(UILongPressGestureRecognizer *)longs{

    if(longs.state == UIGestureRecognizerStateBegan){
         NSLog(@"开始");
        content = self.tempView.text;
        self.toolBar.selected = YES;
        [self startDictating];
    }
    else if (longs.state == UIGestureRecognizerStateEnded){
      self.toolBar.selected = NO;
        [self stopDictating];
         NSLog(@"结束");
    }
    else if(longs.state == UIGestureRecognizerStateChanged){
        NSLog(@"持续中");
    }
}
#pragma mark - 监听键盘方法
/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolBar.y = self.view.height -  self.toolBar.height+5;
        } else {
             self.toolBar.y = keyboardF.origin.y -  self.toolBar.height+5;
        }
    }];
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
