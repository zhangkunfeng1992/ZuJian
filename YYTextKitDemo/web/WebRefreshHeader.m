//
//  WebRefreshHeader.m
//  YYTextKitDemo
//
//  Created by zkf on 2019/8/2.
//  Copyright © 2019 zkf. All rights reserved.
//

#import "WebRefreshHeader.h"

static const CGFloat headerHeight = 54.0;
static const CGFloat alphaAnimationDuration = 0.2f;

@interface WebRefreshHeader ()

@end
@implementation WebRefreshHeader

-(void)prepare{
    [super prepare];
    self.mj_h = headerHeight;
}

-(YYLabel *)resultLB{
    if (!_resultLB) {
        _resultLB = [YYLabel new];
        _resultLB.alpha = 0;
        CGFloat padding = 10;
        _resultLB.font = [UIFont systemFontOfSize:16];
        _resultLB.textAlignment = NSTextAlignmentCenter;
        _resultLB.textColor = [UIColor whiteColor];
        _resultLB.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
        _resultLB.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
        [self addSubview:_resultLB];
    }
    return _resultLB;
}


-(void)placeSubviews{
    [super placeSubviews];
    self.resultLB.frame = self.bounds;
}

-(void)endRefreshing{
    if (self.resultLB.text.length) {
        [UIView animateWithDuration:alphaAnimationDuration animations:^{
            //显示结果
            self.resultLB.alpha = 1.0f;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:alphaAnimationDuration animations:^{
                //显示结果
                self.resultLB.alpha = 0.0f;
            }];
            [super endRefreshing];
        });
    } else {
        [super endRefreshing];
    }
}

- (void)showMessage:(NSString *)msg {
    
//    label.text = msg;
//    label.font = [UIFont systemFontOfSize:16];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
//    label.width = self.view.width;
//    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
//    
//    NSLog(@"%f" , [msg heightForFont:label.font width:label.width]);    label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
//    
//    label.bottom = (kiOS7Later ? 64 : 0);
//    [self.view addSubview:label];
//    [UIView animateWithDuration:0.3 animations:^{
//        label.top = (kiOS7Later ? 64 : 0);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            label.bottom = (kiOS7Later ? 64 : 0);
//        } completion:^(BOOL finished) {
//            [label removeFromSuperview];
//        }];
//    }];
}

@end
