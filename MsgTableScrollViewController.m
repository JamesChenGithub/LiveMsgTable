//
//  MsgTableScrollViewController.m
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import "MsgTableScrollViewController.h"

#import "LiveMsg.h"

@interface MsgTableScrollViewController ()

@end

@implementation MsgTableScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define kMsgMaxCount 50
#define kMsgMinCount 20

- (void)onSendNewMessage:(LiveMsg *)msg
{
    [_msgs addObject:msg];
    if (_msgs.count >= kMsgMaxCount)
    {
        NSRange range = NSMakeRange(_msgs.count - kMsgMinCount, kMsgMinCount);//只保留最新的100条消息
        NSArray *temp = [_msgs subarrayWithRange:range];
        [_msgs removeAllObjects];
        [_msgs addObjectsFromArray:temp];
        
        
        _allOffset = 0;
        for (LiveMsg *im in _msgs)
        {
            _allOffset += im.msgHeight;
        }
    }
    else
    {
        _allOffset += msg.msgHeight;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_msgs.count-1  inSection:0];
    NSArray *array = [_msgTableView indexPathsForVisibleRows];
    NSIndexPath *vilastIndex = array.lastObject;
    if (vilastIndex.row + array.count >= indexPath.row)
    {
        if (_allOffset > _msgTableView.bounds.size.height)
        {
            _msgTableView.contentOffset = CGPointMake(0, _allOffset - _msgTableView.bounds.size.height);
        }
    }
    
    [_msgTableView reloadData];
}

@end

@implementation MsgScrollLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


@implementation MsgScrollTypeViewController

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
        [_msgs removeLastObject];
    }
    
    
    [super onSendNewMessage:msg];
}


@end
