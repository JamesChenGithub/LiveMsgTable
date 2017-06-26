//
//  MsgLevelViewController.h
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import "MsgTableViewController.h"

@interface MsgLevelViewController : MsgTableViewController
{
    NSTimer         *_msgFPSCountTimer;
    NSInteger       _recvMsgCountPerSecond;
    BOOL            _startLimit;
}

@end
