//
//  MainTableViewController.m
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import "MainTableViewController.h"

#import "MsgTableViewController.h"

#import "MsgLevelViewController.h"

#import "MsgTypeViewController.h"

#import "MsgTableScrollViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _datas = @[@"TableView animation方式", @"TableView 根据优先级限频处理", @"TableView 根据优先级,类型合并限频处理"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Table Animation";
    }
    else if (section == 1)
    {
        return @"Table scroll Offset";
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MainCell"];
    }
    
    NSString *kv = _datas[indexPath.row];
    cell.textLabel.text = kv;
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            self.title = @"Base";
            MsgTableViewController *vc = [[MsgTableViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1)
        {
            self.title = @"Level";
            MsgTableViewController *vc = [[MsgLevelViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 2)
        {
            self.title = @"Type";
            MsgTableViewController *vc = [[MsgTypeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            self.title = @"Base";
            MsgTableViewController *vc = [[MsgTableScrollViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1)
        {
            self.title = @"Level";
            MsgTableViewController *vc = [[MsgScrollLevelViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 2)
        {
            self.title = @"Type";
            MsgTableViewController *vc = [[MsgScrollTypeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}




@end
