//
//  ZKFCell.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/13.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "ZKFCell.h"


@implementation ZKFCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

@end
