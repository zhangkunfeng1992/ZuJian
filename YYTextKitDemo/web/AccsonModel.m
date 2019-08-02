//
//  AccsonModel.m
//  新浪微博(终结版)
//
//  Created by lanouhn on 16/1/1.
//  Copyright (c) 2016年 zmh. All rights reserved.
//

#import "AccsonModel.h"



@implementation AccsonModel

/*
 {
 "access_token" = "2.008jaw_DBTyloC2959185925EWKm8E";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3043113105;
 }
 */

+(instancetype)accsonWithDict:(NSDictionary *)dict
{
    AccsonModel *model = [[AccsonModel alloc] init];

    model.access_token = dict[@"access_token"];
    model.expires_in = dict[@"expires_in"];
    model.uid = dict[@"uid"];
    model.creatTime = [NSDate date];
    
    return model;

}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.creatTime forKey:@"creatTime"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.creatTime = [aDecoder decodeObjectForKey:@"creatTime"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
