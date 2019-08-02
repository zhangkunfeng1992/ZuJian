//
//  WebRefreshController.h
//  YYTextKitDemo
//
//  Created by zkf on 2019/8/2.
//  Copyright © 2019 zkf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromiseKit.h"

@interface WebRefreshController : UITableViewController
@property (nonatomic , strong) NSMutableArray *layouts;
-(PMKPromise<NSString *>*)reloadData;
@end
