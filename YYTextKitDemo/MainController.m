//
//  MainController.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/26.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "MainController.h"
#import "ViewController.h"
#import "JianPanViewController.h"
#import "PubuViewController.h"
#import "TestViewController.h"
#import "FuWenbenViewController.h"
#import "WebViewController.h"
#import "ACcountTool.h"
#import "OAuthViewController.h"
#import "WebComposeController.h"
@interface MainController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) NSMutableArray *dataArray;
@end
@implementation MainController

{
    UITableView *_tableView;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:@"自定义布局"];
        [_dataArray addObject:@"键盘测试"];
//        [_dataArray addObject:@"瀑布流"];
        [_dataArray addObject:@"sss"];
        [_dataArray addObject:@"微博"];
//        [_dataArray addObject:@"富文本"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableView];
}
-(void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
}

#pragma mark - tabbleView source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger row = indexPath.row;
    
    AccsonModel *model = [ACcountTool account];
    
    if (!model) {
        OAuthViewController *vc = [[OAuthViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        WebViewController *vc = [[WebViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    if (row == 0) {
//        ViewController *vc = [[ViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    } else if (row == 1) {
//        JianPanViewController *vc = [[JianPanViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    } else if (row == 2) {
//        PubuViewController *vc = [[PubuViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    } else if (row == 3) {
//        TestViewController *vc = [[TestViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    } else if (row == 4) {
//
//        AccsonModel *model = [ACcountTool account];
//
//        if (!model) {
//            OAuthViewController *vc = [[OAuthViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        } else {
//            WebViewController *vc = [[WebViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//
//    } else {
//
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[WebComposeController new]];
//        [self presentViewController:nav animated:YES completion:nil];
////        FuWenbenViewController *vc = [[FuWenbenViewController alloc] init];
////        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}

@end
