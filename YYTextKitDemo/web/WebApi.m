//
//  WebApi.m
//  YYTextKitDemo
//
//  Created by zkf on 2019/8/2.
//  Copyright © 2019 zkf. All rights reserved.
//

#import "WebApi.h"
#import "AFNetworking.h"
#import "ACcountTool.h"
#import "AccsonModel.h"

@implementation WebApi
+(PMKPromise <NSArray *> *)loadNewStatusesWithFirst:(WebStatesLayout *)layout
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    AccsonModel *account = [ACcountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @60;
    if (layout) {
        params[@"since_id"] = layout.status.idstr;
    }
    return [PMKPromise promiseWithResolver:^(PMKResolver resolve) {
        [manger GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            WebTimelineItem *item = [WebTimelineItem modelWithDictionary:responseObject];
            NSMutableArray *new = [NSMutableArray array];
            for (int i = 0; i < item.statuses.count; i++) {
                WebStatus *status = item.statuses[i];
                WebStatesLayout *layout = [[WebStatesLayout alloc] initWithStatus:status];
                [new addObject:layout];
            }
            resolve(new);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            resolve(error);
        }];
        
    }];
}
@end
