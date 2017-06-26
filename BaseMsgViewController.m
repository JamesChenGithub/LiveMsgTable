//
//  BaseMsgViewController.m
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import "BaseMsgViewController.h"
#import "LiveMsg.h"

@interface BaseMsgViewController ()
{
    __weak UIBarButtonItem *_startItem;
    __weak UIBarButtonItem *_addFpsItem;
    __weak UIBarButtonItem *_stopItem;
}

@end

@implementation BaseMsgViewController

- (void)dealloc
{
    NSLog(@"[%@]release", [self class]);
}
- (instancetype)init
{
    if (self = [super init])
    {
        _msgs = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(onStartMsgTest:)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"FPS+" style:UIBarButtonItemStylePlain target:self action:@selector(onFPSAddTest:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"停止" style:UIBarButtonItemStylePlain target:self action:@selector(onStopMsgTest:)];
    
    self.navigationItem.rightBarButtonItems = @[item0, item1, item2];
    
    _msgFPS = 5;
    _startItem = item0;
    _addFpsItem = item1;
    _stopItem = item2;
    
    item0.enabled = YES;
    item1.enabled = NO;
    item2.enabled = NO;
}

- (void)onStartMsgTest:(UIBarButtonItem *)item
{
    _startItem.enabled = NO;
    _addFpsItem.enabled = YES;
    _stopItem.enabled = YES;
    
    if (!_msgTimer)
    {
        _msgTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/_msgFPS target:self selector:@selector(onSendMsg) userInfo:nil repeats:YES];
    }
    self.title = [NSString stringWithFormat:@"随机%ld/s", _msgFPS];
}

- (void)onSendMsg
{
    static int kMsgIndex = 0;
    //    int send = arc4random() % 2;
    //
    //    if (send)
    //    {
    LiveMsg *msg = [[LiveMsg alloc] init];
    msg.content = [NSString stringWithFormat:@"%d : this is the new message", ++kMsgIndex];
    msg.msgHeight = arc4random() % 44 + 20;
    msg.msgLevel = arc4random() % 3;
    msg.msgType = arc4random() % 3;
    [self onSendNewMessage:msg];
    //    }
}

- (void)onSendNewMessage:(LiveMsg *)msg
{
    
}

- (void)onFPSAddTest:(UIBarButtonItem *)item
{
    
    if (_msgFPS < 100)
    {
        [_msgTimer invalidate];
        _msgTimer = nil;
        
        _msgFPS *= 2;
        
        if (!_msgTimer)
        {
            _msgTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/_msgFPS target:self selector:@selector(onSendMsg) userInfo:nil repeats:YES];
        }
        
        self.title = [NSString stringWithFormat:@"随机%ld/s", _msgFPS];
        
    }
}

- (void)onStopMsgTest:(UIBarButtonItem *)item
{
    _startItem.enabled = YES;
    _addFpsItem.enabled = NO;
    _stopItem.enabled = NO;
    
    [_msgTimer invalidate];
    _msgTimer = nil;
    
    _msgFPS = 10;
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
