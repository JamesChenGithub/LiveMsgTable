//
//  MsgTableViewController.m
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import "MsgTableViewController.h"
#import "LiveMsg.h"

@interface MsgTableViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation MsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = self.view.bounds;
    rect = CGRectInset(rect, 0, (rect.size.height - 320)/2);
    UITableView *table = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    
    table.contentOffset = CGPointZero;
    [self.view addSubview:table];
    _msgTableView = table;
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
//        NSLog(@"当前线程main (%d) _msgs.count >= kMsgMaxCount",  [NSThread isMainThread]);
       
        NSRange range = NSMakeRange(_msgs.count - kMsgMinCount, kMsgMinCount);//只保留最新的100条消息
        NSArray *temp = [_msgs subarrayWithRange:range];
        [_msgs removeAllObjects];
        [_msgs addObjectsFromArray:temp];
        [_msgTableView reloadData];
    }
    else
    {
//        NSLog(@"当前线程main (%d) _msgs.count < kMsgMaxCount",  [NSThread isMainThread]);
        [_msgTableView beginUpdates];
        NSIndexPath *index = [NSIndexPath indexPathForRow:_msgs.count - 1 inSection:0];
        [_msgTableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationBottom];
        [_msgTableView endUpdates];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_msgs.count-1  inSection:0];
    NSArray *array = [_msgTableView indexPathsForVisibleRows];
    NSIndexPath *vilastIndex = array.lastObject;
    if (vilastIndex.row + array.count >= indexPath.row)
    {
        [_msgTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"当前线程main (%d) numberOfRowsInSection",  [NSThread isMainThread]);
    return  _msgs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"当前线程main (%d) heightForRowAtIndexPath",  [NSThread isMainThread]);
    LiveMsg *msg = _msgs[indexPath.row];
    return msg.msgHeight;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"当前线程main (%d)  cellForRowAtIndexPath",  [NSThread isMainThread]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MainCell"];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    LiveMsg *msg = _msgs[indexPath.row];
    cell.textLabel.text =  [NSString stringWithFormat:@"%@:level:%ld, type:%ld ", msg.content, msg.msgLevel, msg.msgType];
    return cell;
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
