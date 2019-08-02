//
//  JianPanViewController.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/19.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "JianPanViewController.h"
#import "ChatToolBar.h"
@interface JianPanViewController ()<UITableViewDelegate , UITableViewDataSource , ChatToolBarDelegate>
@property (nonatomic , weak) UITableView *tableView;
@property (nonatomic , strong) ChatToolBar *toolBar;
@end

@implementation JianPanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpTableView];
    
}
-(void)setUpTableView
{
    
    self.toolBar = [[ChatToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    _toolBar.delegate = self;
    [self.view addSubview:_toolBar];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - tabbleView source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.toolBar.textView resignFirstResponder];
}

-(void)chatToolbarDidChangeFrameToHeight:(CGFloat)toHeight andDuration:(CGFloat)duration
{
    [UIView animateWithDuration:3.0 animations:^{
        CGRect rect = self.tableView.frame;
        rect.origin.y = 0;
        rect.size.height = self.view.frame.size.height - toHeight;
        self.tableView.frame = rect;
    }];
    
    [self _scrollViewToBottom:NO];
}

- (void)_scrollViewToBottom:(BOOL)animated
{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:animated];
    }
}

-(void)setToolBar:(ChatToolBar *)toolBar
{
    [_toolBar removeFromSuperview];
    _toolBar = toolBar;
    
    if (_toolBar) {
        [self.view addSubview:_toolBar];
    }
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = self.view.frame.size.height - _toolBar.frame.size.height;
    self.tableView.frame = tableFrame;
    
}

@end
