//
//  WebModel.h
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/15.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WebPicModel : NSObject

@property (nonatomic , strong) NSString *thumbnail_pic;

@end

@interface WebUser : NSObject

@property (nonatomic , strong) NSString *screen_name;
@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *cover_image;
@property (nonatomic , strong) NSString *cover_image_phone;
@property (nonatomic , strong) NSString *profile_image_url;

@property (nonatomic , strong) NSURL *avatar_large;
@property (nonatomic , strong) NSURL *avatar_hd;

@property (nonatomic , assign) NSInteger verified_type;
@property (nonatomic , assign) NSInteger verified_state;
@property (nonatomic , assign) NSInteger verified_level;
@property (nonatomic , assign) NSInteger mbrank;
@end



@interface WebStatus : NSObject

@property (nonatomic , strong) NSDate *created_at;
@property (nonatomic , strong) NSString *text;
@property (nonatomic , strong) NSString *source;
@property (nonatomic , assign) NSInteger source_type;

@property (nonatomic , strong) NSArray *pic_urls;

@property (nonatomic , strong) NSString *thumbnail_pic;
@property (nonatomic , strong) NSString *bmiddle_pic;
@property (nonatomic , strong) NSString *original_pic;
@property (nonatomic , strong) NSString *idstr;


@property (nonatomic , strong) WebStatus *retweeted_status;
@property (nonatomic , strong) WebUser *user;


@property (nonatomic , assign) NSUInteger reposts_count;
@property (nonatomic , assign) NSUInteger comments_count;
@property (nonatomic , assign) NSUInteger attitudes_count;


@end

@interface WebTimelineItem : NSObject

@property (nonatomic , strong) NSArray *statuses;
@property (nonatomic , assign) long max_id;
@end


@interface WebModel : NSObject

@end
