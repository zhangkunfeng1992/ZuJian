//
//  WebViewController.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/13.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "WebViewController.h"
#import "WebCell.h"
#import "WebComposeController.h"
#import "Promise.h"


@interface WebViewController ()< WebCellDelegate>
@property (nonatomic , copy) NSString *since_id;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.layouts = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layouts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[WebCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.delegate = self;
    }
    [cell setLayout:self.layouts[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((WebStatesLayout *)self.layouts[indexPath.row]).height;
}

-(void)CellDidClickLike:(WebCell *)cell
{
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    [self.tableView reloadRowAtIndexPath:path withRowAnimation:UITableViewRowAnimationNone];
}

-(void)CellDidClickComment:(WebCell *)cell
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[WebComposeController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
