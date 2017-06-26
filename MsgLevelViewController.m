//
//  MsgLevelViewController.m
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import "MsgLevelViewController.h"

#import "LiveMsg.h"
@interface MsgLevelViewController ()


@end

@implementation MsgLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated;
}

- (void)onStartMsgTest:(UIBarButtonItem *)item
{
    [super onStartMsgTest:item];
    
    if (!_msgFPSCountTimer)
    {
        _msgFPSCountTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onCountMsgRecv) userInfo:nil repeats:YES];
    }
}

- (void)onCountMsgRecv
{
    if (_recvMsgCountPerSecond >= 5)
    {
        _startLimit = YES;
    }
    else
    {
        _startLimit = NO;
    }
    
    _recvMsgCountPerSecond = 0;
}

- (void)onStopMsgTest:(UIBarButtonItem *)item
{
    [super onStopMsgTest:item];
    [_msgFPSCountTimer invalidate];
    _msgFPSCountTimer = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onSendNewMessage:(LiveMsg *)msg
{
    _recvMsgCountPerSecond++;
    if (_startLimit)
    {
        if (msg.msgLevel <= 1)
        {
            return;
        }
    }
    [super onSendNewMessage:msg];
}



@end
