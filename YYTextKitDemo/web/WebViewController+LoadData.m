//
//  WebViewController+LoadData.m
//  YYTextKitDemo
//
//  Created by zkf on 2019/8/2.
//  Copyright © 2019 zkf. All rights reserved.
//

#import "WebViewController.h"
#import "WebApi.h"

@implementation WebViewController (LoadData)
-(PMKPromise<NSString *> *)reloadData{
    return [WebApi loadNewStatusesWithFirst:(WebStatesLayout *)self.layouts.firstObject].then(^(NSArray *newArray){
        [self.layouts insertObjects:newArray atIndex:0];
        [self.tableView reloadData];
        if (newArray.count) {
            return [PMKPromise promiseWithValue:[NSString stringWithFormat:@"更新了%ld条微博" , newArray.count]];
        }
        return [PMKPromise promiseWithValue:@"暂无最新微博"];
    });
}
@end
