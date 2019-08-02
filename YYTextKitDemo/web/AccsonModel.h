//
//  AccsonModel.h
//  新浪微博(终结版)
//
//  Created by lanouhn on 16/1/1.
//  Copyright (c) 2016年 zmh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccsonModel : NSObject <NSCoding>

/*
 {
 "access_token" = "2.008jaw_DBTyloC2959185925EWKm8E";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3043113105;
 }
 */


@property (nonatomic , copy) NSString *access_token;
@property (nonatomic , copy) NSString *expires_in;
@property (nonatomic , copy) NSString *uid;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , strong) NSDate *creatTime;


+(instancetype)accsonWithDict:(NSDictionary *)dict;
@end
