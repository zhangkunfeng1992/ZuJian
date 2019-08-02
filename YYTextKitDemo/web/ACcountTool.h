//
//  ACcountTool.h
//  新浪微博(终结版)
//
//  Created by lanouhn on 16/1/4.
//  Copyright (c) 2016年 zmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccsonModel.h"
@class AccsonModel;
@interface ACcountTool : NSObject

+(void)saveAccount:(AccsonModel *)account;
+(AccsonModel *)account;
@end
