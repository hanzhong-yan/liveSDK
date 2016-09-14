//
//  StartLiveViewController.m
//  TabNavigation
//
//  Created by hanzhong.yan on 16/7/5.
//  Copyright © 2016年 shata. All rights reserved.
//

#import "StartLiveViewController.h"
#import "LiveShowViewController.h"

@interface StartLiveViewController ()

@end

@implementation StartLiveViewController{
    UITextField* _RtmpUrlTextField;
    UIButton* _StartButton;
    LiveShowViewController *_LiveShowViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIInit];
    // Do any additional setup after loading the view.
    _RtmpUrlTextField.text = @"rtmp://172.30.41.169/test/123456";
}


-(void) UIInit{
    double fScreenW = [UIScreen mainScreen].bounds.size.width;
    
    
    
    float fRtmpUrlTextFieldX = 10;
    float fRtmpUrlTextFieldY = 100;
    float fRtmpUrlTextFieldW = fScreenW-2*fRtmpUrlTextFieldX;
    float fRtmpUrlTextFieldH = 30;
    _RtmpUrlTextField = [[UITextField alloc] initWithFrame:CGRectMake(fRtmpUrlTextFieldX, fRtmpUrlTextFieldY, fRtmpUrlTextFieldW, fRtmpUrlTextFieldH)];
    _RtmpUrlTextField.backgroundColor = [UIColor lightGrayColor];
    [_RtmpUrlTextField setTextColor:[UIColor whiteColor]];
    _RtmpUrlTextField.layer.masksToBounds = YES;
    _RtmpUrlTextField.layer.cornerRadius  = 5;
    _RtmpUrlTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_RtmpUrlTextField];
    
    float fStartButtonW = 70;
    float fStartButtonH = 30;
    float fStartButtonX = fScreenW/2-fStartButtonW/2;
    float fStartButtonY = fRtmpUrlTextFieldY+fRtmpUrlTextFieldH+10;
    _StartButton = [[UIButton alloc] initWithFrame:CGRectMake(fStartButtonX, fStartButtonY, fStartButtonW, fStartButtonH)];
    _StartButton.backgroundColor = [UIColor blueColor];
    _StartButton.layer.masksToBounds = YES;
    _StartButton.layer.cornerRadius  = 5;
    [_StartButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [_StartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _StartButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    [_StartButton addTarget:self action:@selector(OnStartLiveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_StartButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)OnStartLiveClicked:(id)sender{
    NSLog(@"Start live Rtmp:%@", _RtmpUrlTextField.text);
    _LiveShowViewController = [[LiveShowViewController alloc] init];
    
    //[_LiveShowViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    _LiveShowViewController.RtmpUrl = [NSURL URLWithString:_RtmpUrlTextField.text];
    _LiveShowViewController.IsHorizontal = NO;
    
    [self presentModalViewController:_LiveShowViewController animated:YES];
}


//隐藏键盘的方法
-(void)hidenKeyboard
{
    [_RtmpUrlTextField resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_RtmpUrlTextField isExclusiveTouch]) {
        [_RtmpUrlTextField resignFirstResponder];
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
