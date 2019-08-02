//
//  ACcountTool.m
//  新浪微博(终结版)
//
//  Created by lanouhn on 16/1/4.
//  Copyright (c) 2016年 zmh. All rights reserved.
//

#import "ACcountTool.h"

#define kPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.plist"]

@implementation ACcountTool
+(void)saveAccount:(AccsonModel *)account
{
    
    account.creatTime = [NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:kPath];
}

+(AccsonModel *)account{

    AccsonModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:kPath];
    
    long long expires_in = [model.expires_in longLongValue];
    NSDate *expiresTime = [model.creatTime dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    
    if (result == NSOrderedAscending || result == NSOrderedSame) {
        return nil;
    }

    return model;
  
}
@end
