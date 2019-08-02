//
//  WebApi.h
//  YYTextKitDemo
//
//  Created by zkf on 2019/8/2.
//  Copyright © 2019 zkf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebModel.h"
#import "PromiseKit.h"
#import "WebStatesLayout.h"

@interface WebApi : NSObject+(PMKPromise <NSArray *> *)loadNewStatusesWithFirst:(WebStatesLayout *)layout;
@end

