//
//  MsgTypeViewController.m
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import "MsgTypeViewController.h"

#import "LiveMsg.h"

@interface MsgTypeViewController ()

@end

@implementation MsgTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    LiveMsg *lm = [_msgs lastObject];
    
    if (lm.msgType == msg.msgType)
    {
        [_msgTableView beginUpdates];
        [_msgs replaceObjectAtIndex:_msgs.count-1 withObject:msg];
        NSIndexPath *ide = [NSIndexPath indexPathForRow:_msgs.count-1 inSection:0];
        [_msgTableView reloadRowsAtIndexPaths:@[ide] withRowAnimation:UITableViewRowAnimationFade];
        [_msgTableView endUpdates];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_msgs.count-1  inSection:0];
        NSArray *array = [_msgTableView indexPathsForVisibleRows];
        NSIndexPath *vilastIndex = array.lastObject;
        if (vilastIndex.row + array.count >= indexPath.row)
        {
            [_msgTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        return;
    }
    
    
    [super onSendNewMessage:msg];
}



@end
