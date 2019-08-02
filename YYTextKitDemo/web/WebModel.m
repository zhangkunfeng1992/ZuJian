//
//  WebModel.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/15.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "WebModel.h"
@implementation WebUser


@end

@implementation WebStatus

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pic_urls" : [WebPicModel class]};
}

@end

@implementation WebTimelineItem

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"hasVisible" : @"hasvisible",
//             @"previousCursor" : @"previous_cursor",
//             @"uveBlank" : @"uve_blank",
//             @"hasUnread" : @"has_unread",
//             @"totalNumber" : @"total_number",
//             @"maxID" : @"max_id",
//             @"sinceID" : @"since_id",
//             @"nextCursor" : @"next_cursor"};
//}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"statuses" : [WebStatus class]};
}




@end


@implementation WebPicModel

-(void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
@implementation WebModel

@end
