//
//  BaseMsgViewController.h
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiveMsg;

@interface BaseMsgViewController : UIViewController
{
    NSTimer *_msgTimer;
    
    NSInteger _msgFPS;
    
    NSMutableArray *_msgs;
}

- (void)onSendNewMessage:(LiveMsg *)msg;

- (void)onStartMsgTest:(UIBarButtonItem *)item;

- (void)onFPSAddTest:(UIBarButtonItem *)item;

- (void)onStopMsgTest:(UIBarButtonItem *)item;


@end
