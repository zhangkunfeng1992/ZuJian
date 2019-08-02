//
//  WebRefreshController.m
//  YYTextKitDemo
//
//  Created by zkf on 2019/8/2.
//  Copyright © 2019 zkf. All rights reserved.
//

#import "WebRefreshController.h"
#import "WebRefreshHeader.h"
#import "YYFPSLabel.h"
#import "MJRefresh.h"
#import "YYKit.h"

@interface WebRefreshController ()<UIScrollViewDelegate>
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation WebRefreshController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRefreshHeader];
//
//    _fpsLabel = [YYFPSLabel new];
//    [_fpsLabel sizeToFit];
//    _fpsLabel.bottom = self.view.height - kWBCellPadding;
//    _fpsLabel.left = kWBCellPadding;
//    _fpsLabel.alpha = 0;
//    [self.view addSubview:_fpsLabel];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)setUpRefreshHeader{
    WebRefreshHeader *header = [WebRefreshHeader new];
    header.tintColor = [UIColor redColor];
    __weak typeof(self) weakSelf = self;
    __weak typeof(WebRefreshHeader) *weakHeader = header;
    header.refreshingBlock = ^(){
        [weakSelf reloadData].then(^(NSString *str){
            weakHeader.resultLB.text = str;
            [weakSelf.tableView.mj_header endRefreshing];
        }).catch(^(NSError *error){
            [weakSelf.tableView.mj_header endRefreshing];
        });
    };
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

-(PMKPromise<NSString *> *)reloadData{
    return [PMKPromise promiseWithValue:@""];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}


@end
